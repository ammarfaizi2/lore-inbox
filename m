Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316254AbSEVRFu>; Wed, 22 May 2002 13:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSEVRFu>; Wed, 22 May 2002 13:05:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26884 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316254AbSEVRFs>; Wed, 22 May 2002 13:05:48 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: jsimmons@transvirtual.com (James Simmons)
Date: Wed, 22 May 2002 18:25:47 +0100 (BST)
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10205220924310.4611-100000@www.transvirtual.com> from "James Simmons" at May 22, 2002 09:30:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AZrv-0002Ia-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan you are thinking to PC here. On embedded devices that run X it is
> just extra over head to use the VT interface. It would be much lighter
> weigth to use the /dev/input/event interface. Personally I like to see
> KBDRATE and alot of other junk go away in the console code. Intead we
> just use the input api and /dev/fb with DRI. I have talked to Jim Getty
> about this and likes to see things head in this direction.

DRI ? What good is DRI to me on an embedded box. What good is an fb driver
when my hardware does text mode ? Why do I want the whole input layer loaded
for a single fixed keyboard controller, or a serial interface driven by user
mode ?


