Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263266AbSJCO5X>; Thu, 3 Oct 2002 10:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263302AbSJCO5X>; Thu, 3 Oct 2002 10:57:23 -0400
Received: from isis.lip6.fr ([132.227.60.2]:64014 "EHLO isis.lip6.fr")
	by vger.kernel.org with ESMTP id <S263266AbSJCO5W>;
	Thu, 3 Oct 2002 10:57:22 -0400
X-pt: isis.lip6.fr
Date: Thu, 3 Oct 2002 17:02:52 +0200 (CEST)
From: Cedric Roux <Cedric.Roux@lip6.fr>
Reply-To: Cedric.Roux@lip6.fr
To: linux-kernel@vger.kernel.org
Subject: ipc - msg - ERRATA
Message-ID: <Pine.LNX.4.44.0210031659200.18081-100000@ouessant.lip6.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it is 20 bytes for a struct msg_msg, not 36, which
leads to 20 * 16 * 16384 = 5242880 bytes used, not
36 * 16 * 16384 = 9437184
sorry.

-- 
main(){int i,j;{printf("\n      Who did you say ? Sierpinski ?      \n");}
for(i=0;i<80;i++){for(j=0;j<80;j++)printf("%c",i&j?'.':' ');printf("\n");}
printf("\n   Life is a beach - George Sand (1804-1876)  \n\n"); return 0;}

