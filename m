Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbTBHQni>; Sat, 8 Feb 2003 11:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbTBHQni>; Sat, 8 Feb 2003 11:43:38 -0500
Received: from dsl-213-023-051-140.arcor-ip.net ([213.23.51.140]:4527 "EHLO
	pulsar.homelinux.net") by vger.kernel.org with ESMTP
	id <S267052AbTBHQnh>; Sat, 8 Feb 2003 11:43:37 -0500
Message-ID: <3E45358F.8020509@pulsar.homelinux.net>
Date: Sat, 08 Feb 2003 17:51:27 +0100
From: Uwe Reimann <linux-kernel@pulsar.homelinux.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ENTRY-macro in linkage.h
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently porting linux to TI's TMS320C31. I'm using c4x-gcc, which 
has a problem with the ENTRY-macro from linkage.h. c4x-gcc will accept 
the generated .globl-directive only if it is preceded by whitescape. 
Right know, gcc thinks I want to create a label called .globl. Any ideas 
how to fix this without fixing gcc?

Regards, Uwe


