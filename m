Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTDUWvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTDUWvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:51:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50953 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262623AbTDUWvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 18:51:08 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new system call mknod64
Date: 21 Apr 2003 16:02:47 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b81tan$637$1@cesium.transmeta.com>
References: <UTC200304212143.h3LLh6e02148.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <UTC200304212143.h3LLh6e02148.aeb@smtp.cwi.nl>
By author:    Andries.Brouwer@cwi.nl
In newsgroup: linux.dev.kernel
> 
> and in fact the patches I have been giving out use kdev_t
> as internal format, where you can think of kdev_t as
> u64, or, if you prefer, as struct { u32 major, minor; }.
> 

Any reason why we don't just *make it* a struct?  (Well, besides that
it'd somewhat suck on 64-bit architectures?)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
