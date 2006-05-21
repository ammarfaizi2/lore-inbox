Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWEUTIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWEUTIO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWEUTIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:08:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19682 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964913AbWEUTIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:08:13 -0400
Date: Sun, 21 May 2006 15:08:06 -0400
From: Dave Jones <davej@redhat.com>
To: Ameer Armaly <ameer@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] initialize variables in fs/isofs/namei.c
Message-ID: <20060521190806.GE8250@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ameer Armaly <ameer@bellsouth.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0605211501150.2255@sg1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605211501150.2255@sg1>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 03:02:34PM -0400, Ameer Armaly wrote:
 > This patch removes un-initialized variable warnings for block and offset in 
 > namei.c, which are later initialized through a call to isofs_find_entry().

Which indicates the problem lies with gcc, just like with the other patches
'fixing' these warnings.

The warning is bogus.

		Dave

-- 
http://www.codemonkey.org.uk
