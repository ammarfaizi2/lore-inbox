Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289795AbSBOPzb>; Fri, 15 Feb 2002 10:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289877AbSBOPzT>; Fri, 15 Feb 2002 10:55:19 -0500
Received: from mail2.home.nl ([213.51.129.226]:2707 "EHLO mail2.home.nl")
	by vger.kernel.org with ESMTP id <S289795AbSBOPzI>;
	Fri, 15 Feb 2002 10:55:08 -0500
Subject: 2.5.5-pre1 matroxfb compileproblem
From: Luuk van der Duim <l.a.van.der.duim@student.rug.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.21mdk 
Date: 15 Feb 2002 16:54:25 +0100
Message-Id: <1013788465.13368.2.camel@CC75757-A>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling 2.5.5-pre1 I ran into this problem:

    
    matroxfb_base.c: In function `matroxfb_ioctl':
    matroxfb_base.c:1062: warning: implicit declaration of function
    `matroxfb_switch'
    matroxfb_base.c: In function `initMatrox2':
    matroxfb_base.c:1792: incompatible types in assignment
    make[4]: *** [matroxfb_base.o] Error 1
    make[4]: Leaving directory
    `/usr/src/linux-2.5.5-pre1/drivers/video/matrox'
    make[3]: *** [first_rule] Error 2
    make[3]: Leaving directory
    `/usr/src/linux-2.5.5-pre1/drivers/video/matrox'
    make[2]: *** [_subdir_matrox] Error 2
    make[2]: Leaving directory `/usr/src/linux-2.5.5-pre1/drivers/video'
    make[1]: *** [_subdir_video] Error 2
    make[1]: Leaving directory `/usr/src/linux-2.5.5-pre1/drivers'
    make: *** [_dir_drivers] Error 2
    
    
Yours,

Luuk van der Duim

