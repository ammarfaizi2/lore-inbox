Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbTAWUtN>; Thu, 23 Jan 2003 15:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbTAWUtM>; Thu, 23 Jan 2003 15:49:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:14794 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266731AbTAWUtM>; Thu, 23 Jan 2003 15:49:12 -0500
To: linux-kernel@vger.kernel.org
Subject: Bug in awedrv
From: public@zakweb.de
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Originating-From: 6593015
X-Binford: 6100 (more power)
Message-Id: <E18boQX-00079s-00@config7.kundenserver.de>
Date: Thu, 23 Jan 2003 21:58:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
I use Debian woody and just tried to compile my first own kernel. As I
did so the compiler warned me about a failing identifier in
/drivers/sound/awe_wave.c in line 2896 (AWE_REMOVE_INFO). I don't know
much about C and nothing about kernel programming, but I searched in all
#include<*> files after any "patch" struct and found one
(/include/linux/awe_voice.h) in which I inserted one line  (after line58
"#de#define AWE_REMOVE_INFO 7, which helped to compile the kernel
without failures. I don't know how it helped because the struct had
another name. But I just thought it could help you if I write this to
you.

GbY,madroach
