Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129689AbRBUDtB>; Tue, 20 Feb 2001 22:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbRBUDsw>; Tue, 20 Feb 2001 22:48:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46864 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129689AbRBUDso>; Tue, 20 Feb 2001 22:48:44 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Newbie ask for help: cramfs port to isofs
Date: 20 Feb 2001 19:48:17 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <96vdq1$t90$1@cesium.transmeta.com>
In-Reply-To: <877l2lyk3j.fsf@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <877l2lyk3j.fsf@debian.org>
By author:    zhaoway <zw@debian.org>
In newsgroup: linux.dev.kernel
> 
> I plan to automatically de-compressing ``*.cramed'' files made with
> cramit.c (which is a simplified version of mkcramfs.c also attached
> below) from within isofs.o. This indeed isn't a very clean idea I
> agree. If you have better design, please let me know.
> 

It would be better to have this controlled by SUSP records.  It looks
like the -z option to mkisofs was intended to do this, but it never
quite got done and integrated.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
