Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132904AbRDEOgI>; Thu, 5 Apr 2001 10:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132906AbRDEOf7>; Thu, 5 Apr 2001 10:35:59 -0400
Received: from highland.isltd.insignia.com ([195.217.222.20]:21510 "EHLO
	highland.isltd.insignia.com") by vger.kernel.org with ESMTP
	id <S132904AbRDEOfk>; Thu, 5 Apr 2001 10:35:40 -0400
Message-ID: <3ACC82C9.F1C046CE@insignia.com>
Date: Thu, 05 Apr 2001 15:35:53 +0100
From: Stephen Thomas <stephen.thomas@insignia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joseph Carter <knghtbrd@debian.org>
CC: Bart Trojanowski <bart@jukie.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
In-Reply-To: <20010405072628.C22001@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Carter wrote:
> This doesn't follow in my mind.  I can't think of a case where a { ... }
> would fail, but a do { ... } while (0) would succeed.  The former would
> also save a few keystrokes.

#define FOO(x) { wibble(x); wobble((x)+1);}

   if (something)
      FOO(23);
   else            /* Compile goes crump here. */
      another_thing();


Stephen Thomas
