Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273985AbRI3TJ4>; Sun, 30 Sep 2001 15:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273990AbRI3TJq>; Sun, 30 Sep 2001 15:09:46 -0400
Received: from web13904.mail.yahoo.com ([216.136.175.67]:27917 "HELO
	web13904.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273985AbRI3TJ0>; Sun, 30 Sep 2001 15:09:26 -0400
Message-ID: <20010930190954.18227.qmail@web13904.mail.yahoo.com>
Date: Sun, 30 Sep 2001 12:09:54 -0700 (PDT)
From: Belinda <belinda_ye@yahoo.com>
Subject: inb() and outb()
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

I wrote a simple program with inb() and outb().
However, it reports the segmentation error when
running it. 

The code follows as: 
---------------------------------
#include <asm/io.h>

#define LPT 0x378

void write_LPT(unsigned char byte) 
{
    outb(byte, LPT);
}

int main()
{
   write_LPT(LPT);
   printf("Value:%c", inb(LPT));

}
------------------------------------------------------

Thanks,

Belinda

__________________________________________________
Do You Yahoo!?
Listen to your Yahoo! Mail messages from any phone.
http://phone.yahoo.com
