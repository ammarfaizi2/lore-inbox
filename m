Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTJMO3U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTJMO3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:29:20 -0400
Received: from virt-216-40-198-21.rackshack.net ([216.40.198.21]:53508 "EHLO
	virt-216-40-198-21.ev1servers.net") by vger.kernel.org with ESMTP
	id S261744AbTJMO3T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:29:19 -0400
Date: Mon, 13 Oct 2003 09:24:02 -0500
From: Chuck Campbell <campbell@accelinc.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Message-ID: <20031013142402.GA6244@helium.inexs.com>
Reply-To: campbell@accelinc.com
Mail-Followup-To: Chuck Campbell <campbell@accelinc.com>,
	linux-kernel@vger.kernel.org
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 07:24:00PM +0900, Norman Diamond wrote:
> 
> I agree, we are not sure if a read will do that.  That is the reason why two
> of my preceding questions were:
> 
>    How can I find out which file contains the bad sector?  I would like to
>    try to recreate the file from a source of good data.

this was gibven to me  on this list by Al Viro a couple of years back.  
Worked fine for me.

find /usr/lib -type f|sed -e 's!.*!cat & >/dev/null || echo &!'|sh

-- 
