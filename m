Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315523AbSECBVO>; Thu, 2 May 2002 21:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSECBVM>; Thu, 2 May 2002 21:21:12 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:24666 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S315523AbSECBVJ>; Thu, 2 May 2002 21:21:09 -0400
Date: Fri, 3 May 2002 02:28:59 +0100
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: thumb stuff
Message-Id: <20020503022859.516708ee.spyro@armlinux.org>
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.5cvs1 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Can anyone tll me what address the following will branch to?
I've looked at 6ba4, 6ba4>>1, 6ba4<<1, 6ba4<<2 and PC+6ba4, but none of
them seem to make sense. (yes, I know there will be thumb code there).


   a08bc:       e59fc000        ldr     ip, [pc, #0]    ; a08c4
<_binary_bin_16_size+0x1e0>
   a08c0:       e12fff1c        bx      ip
   a08c4:       00006ba5        andeq   r6, r0, r5, lsr #23

Thanks for any help :)
