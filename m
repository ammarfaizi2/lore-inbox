Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUGXPuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUGXPuN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUGXPuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:50:13 -0400
Received: from main.gmane.org ([80.91.224.249]:6320 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261500AbUGXPuJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:50:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Andreas Henriksson" <andreas@fjortis.info>
Subject: Re: [PATCH] Delete cryptoloop
Date: Sat, 24 Jul 2004 16:08:03 +0200
Organization: Fjortis.info Ltd.
Message-ID: <opsbnavpsunsiesp@localhost>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <1090672906.8587.66.camel@ghanima> <20040724095245.73ca26fe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-1-9a.ghn.gbg.bostream.se
User-Agent: Opera M2/7.50 (Linux, build 673)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jul 2004 09:52:45 -0700, Andrew Morton <akpm@osdl.org> wrote:

>
> I think I'd rather add a patch which does printk("cryptoloop will be
> removed from Linux on June 30, 2005.  Please migrate to dm-crypt")

If "helping users" understand that cryptoloop is a band alternative is the  
main reason I think removing it is a bad idea.
If EXPERIMENTAL isn't discuraging enough why not use BROKEN? That way they  
will for sure know that something is wrong but can still upgrade their  
kernel without fearing to not get their data back because they can't get  
this "new thing" (dm-crypt) running.

-- 
Regards,
Andreas Henriksson
andreas at fjortis.info

