Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWIBHWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWIBHWv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 03:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWIBHWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 03:22:51 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:3722 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750823AbWIBHWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 03:22:50 -0400
Date: Sat, 2 Sep 2006 09:18:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven French <sfrench@us.ibm.com>
cc: akpm@osdl.org, linux-cifs-client@lists.samba.org,
       linux-kernel@vger.kernel.org,
       Richard Knutsson <ricknu-0@student.ltu.se>, sfrench@samba.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 1/2] fs/cifs: Converting into generic
 boolean
In-Reply-To: <OFE86A755F.DEA60E1E-ON872571DC.00732934-862571DC.00739039@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0609020918010.24701@yvahk01.tjqt.qr>
References: <OFE86A755F.DEA60E1E-ON872571DC.00732934-862571DC.00739039@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Should not this become 'bool use_ntlmssp'? Possibly in a later patch?

>Yes, but ...
>fs/cifs/asn1.c file may go away eventually .  After getting most of the way
>through implementation quite a while ago, I realized that it would be too
>risky to rely on SPNEGO parsing in kernel (too easy to overrun buffers)
>unless the kernel had dedicated asn1 library (which would be very hard)

That sounds like it would be best to make it a FUSE.


Jan Engelhardt
-- 

-- 
VGER BF report: H 0.000513496
