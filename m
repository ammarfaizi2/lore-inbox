Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbRENWON>; Mon, 14 May 2001 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbRENWOD>; Mon, 14 May 2001 18:14:03 -0400
Received: from free91.30.webperception.com ([64.7.91.30]:22035 "HELO
	ataras.com") by vger.kernel.org with SMTP id <S262526AbRENWNv>;
	Mon, 14 May 2001 18:13:51 -0400
Message-ID: <3B004A9F.B616597A@ataras.com>
Date: Mon, 14 May 2001 15:14:07 -0600
From: Bill Ataras <bill@ataras.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: driver/media/video/buz.c breaks build?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

buz.c references KMALLOC_MAXSIZE which appears to be no longer defined.
In order to build it, I've had to re-add this define to slab.h.

Saw it in 2.4.3. Still in 2.4.4

sorry new to this list.
