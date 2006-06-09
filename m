Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWFIU27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWFIU27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWFIU27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:28:59 -0400
Received: from hera.kernel.org ([140.211.167.34]:36260 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932132AbWFIU26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:28:58 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs: who does cat init.sh >> init ?
Date: Fri, 9 Jun 2006 13:28:47 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6cllv$dnb$1@terminus.zytor.com>
References: <4489D93F.7090401@protei.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149884927 14060 127.0.0.1 (9 Jun 2006 20:28:47 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 9 Jun 2006 20:28:47 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4489D93F.7090401@protei.ru>
By author:    Nickolay <nickolay@protei.ru>
In newsgroup: linux.dev.kernel
>
> Guys, in recent kernels, when building kernel with initramfs with V=1, 
> i  see interesting one:
> 
> cat /usr/kernel/BE/2_6/initramfs/init.sh >/usr/kernel/BE/2_6/initramfs/init
> 
> But i can't find, who really do that. Can anyone point me?
> I need to fix that, because it's impossible for me to have two copy of init.
> 

Nothing that's part of the standard kernel, that's for sure.

Looks like you have something patched, possibly by a vendor.  The
BE/2_6 bit definitely looks that way.

	-hpa
