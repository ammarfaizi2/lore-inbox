Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVAPTVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVAPTVa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVAPTV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:21:29 -0500
Received: from holomorphy.com ([66.93.40.71]:42707 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262579AbVAPTVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:21:03 -0500
Date: Sun, 16 Jan 2005 11:20:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Drake <dsd@gentoo.org>
Cc: Joseph Fannin <jhf@rivenstone.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       William Park <opengeometry@yahoo.ca>
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050116192052.GN3474@holomorphy.com>
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net> <41EABBEB.10702@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EABBEB.10702@gentoo.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Fannin wrote:
>>    With this patch, initrds seem to get 'skipped'.  I think this is
>> probably the cause for the reports of problems with RAID too.

On Sun, Jan 16, 2005 at 07:09:31PM +0000, Daniel Drake wrote:
> This seems likely and is probably also the cause of wli's problems 
> mentioned elsewhere in this thread.
> I had overlooked the way that initrd's work in that part of the boot 
> sequence. Will investigate.

akpm suspected this immediately, and my tests confirmed it.

I should probably do the work to make the box boot with CONFIG_MODULES=n
as I don't like initrd's or modules anyway (new points of failure).


-- wli
