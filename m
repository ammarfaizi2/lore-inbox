Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315969AbSETNTv>; Mon, 20 May 2002 09:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315974AbSETNTu>; Mon, 20 May 2002 09:19:50 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:29897 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S315969AbSETNTt>; Mon, 20 May 2002 09:19:49 -0400
Date: Mon, 20 May 2002 15:25:07 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: A cosmetic but useful change on soundcard.h
Message-ID: <3CE8F933.mail58K110Q6B@viadomus.com>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello all :)

    I've seen that the device names and device labels for the mixer
on soundcard.h are somewhat incongruent. It seems that the first
labels and names length is 5 characters, even padding shorter ones
with spaces, but newly added labels are longer than that.

    Would be possible (I can make the patch, is *very* easy) to pad
*all* labels and names so all them are of the same size? Moreover,
adding a #define with that size would help a lot user-space apps like
mixers and the like. Simply using '80' as the size doesn't help, and
I've seen a couple of mixer doing this...

    How about it?

    Raúl
