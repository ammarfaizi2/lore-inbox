Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbTAOUUx>; Wed, 15 Jan 2003 15:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTAOUUx>; Wed, 15 Jan 2003 15:20:53 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:21136 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP
	id <S267198AbTAOUUw>; Wed, 15 Jan 2003 15:20:52 -0500
Message-ID: <3E25C433.2080303@free.fr>
Date: Wed, 15 Jan 2003 21:27:31 +0100
From: Arnaud Quette <arnaud.quette@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel-ml <linux-kernel@vger.kernel.org>
Subject: 2.5.58: headers fbcon[*].h are missing in include/video/
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

when compiling 2.5.58, I get hosts of
"drivers/video/sis/sis_main.c:XX:YY: video/fbcon[*].h: no such file or 
dir" !

Investigatig a bit, I found that several FB headers are missing in
"include/video/" since 2.5.48 (the last one I have that has those 
missing files):
fbcon.h, fbcon-cfb8.h, fbcon-cfb16.h, fbcon-cfb24.h, fbcon-cfb32.h, 
fbcon-accel.h, ...

I've of course [re-re-re-re]checked with different archives and 
different versions...
Am I in the 4th dimension, or have I missed something ?

Arnaud


