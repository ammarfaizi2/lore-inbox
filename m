Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313115AbSDSWhz>; Fri, 19 Apr 2002 18:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313116AbSDSWhy>; Fri, 19 Apr 2002 18:37:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31749 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313115AbSDSWgf>; Fri, 19 Apr 2002 18:36:35 -0400
Subject: Re: [PATCH] 2.4.19-pre7 New Driver synclink_cs.c
To: paulkf@microgate.com (Paul Fulghum)
Date: Fri, 19 Apr 2002 23:54:36 +0100 (BST)
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1019239480.1139.1.camel@diemos.microgate.com> from "Paul Fulghum" at Apr 19, 2002 01:04:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yhH2-00086S-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch is against 2.4.19-pre7
> Please apply.

Can you fix the random global variables and the mysterious "this function 
feels like 4 space tab, this one 8 space" bits. Mostly the global. A 
MODULE_PARM() doesn't need to be global
