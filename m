Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277398AbRJOLcR>; Mon, 15 Oct 2001 07:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277399AbRJOLcH>; Mon, 15 Oct 2001 07:32:07 -0400
Received: from mx9.port.ru ([194.67.57.19]:41872 "EHLO mx9.port.ru")
	by vger.kernel.org with ESMTP id <S277398AbRJOLb4>;
	Mon, 15 Oct 2001 07:31:56 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200110151134.f9FBYkS00992@vegae.deep.net>
Subject: Re: crc32 cleanups
To: bjorn@sparta.lu.se
Date: Mon, 15 Oct 2001 15:34:45 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does not work if all the code that uses crc32 is in a module.  No
> > references from the main kernel so crc32 is not included by the linker.
>
> So make the CRC32 code a module itself ?
   Nasty idea, since its ideologically unclean.
   The idea behind the CONFIG_xxx options is to give user the control over
 the kernel content in the cases he really can win from it.
   I suppose no sane user knows what crc32 is needed by, nor even whats it..   
   Nor he should, since maximum of his knowledge lies in device selection,
 which is the proper source for such information.

   What i`m trying to say is that CONFIG_xxx is just the wrong information
 bearer for that.

Cheers, Samium Gromoff

