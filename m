Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbTBBBoG>; Sat, 1 Feb 2003 20:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTBBBoF>; Sat, 1 Feb 2003 20:44:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33043 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264797AbTBBBoF>; Sat, 1 Feb 2003 20:44:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: futimes()?
Date: 1 Feb 2003 17:53:22 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b1htmi$9r6$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the general vein of avoiding security holes by using file
descriptors when doing repeated operations on the same filesystem
object, I have noticed that there doesn't seem to be a way to set
mtime using a file descriptor.  Do we need a futimes() syscall?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
