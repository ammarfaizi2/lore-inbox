Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287003AbSAUOtt>; Mon, 21 Jan 2002 09:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287109AbSAUOtj>; Mon, 21 Jan 2002 09:49:39 -0500
Received: from mail2.alcatel.fr ([212.208.74.132]:26307 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S287003AbSAUOt2>;
	Mon, 21 Jan 2002 09:49:28 -0500
Message-ID: <3C4C2A6D.1431CE41@sxb.bsf.alcatel.fr>
Date: Mon, 21 Jan 2002 15:49:18 +0100
From: Denis RICHARD <dri@sxb.bsf.alcatel.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Yves LUDWIG <Yves.Ludwig@sxb.bsf.alcatel.fr>,
        Pierre PEIFFER <Pierre.Peiffer@sxb.bsf.alcatel.fr>,
        Denis RICHARD <Denis.Richard@sxb.bsf.alcatel.fr>,
        Philippe MARTEAU <Philippe.Marteau@sxb.bsf.alcatel.fr>
Subject: New version of e2compress patch (0.4.42) for LINUX 2.4.16.
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mangalore.zipworld.com.au id BAA03206

Hi,

A new version of the e2compress patch (0.4.42) for kernel 2.4.16 is available.

Changes from 0.4.41 to 0.4.42 :
===============================
 - Delete the i_blocks field decrementation (Thanks to Peter Wächtler).
 - Clear dirty bit of buffers not in compressed area, after compression.
 - Unlock pages before sync of inode, after compression.
 - Change parameters (OSYNC_METADATA|OSYNC_DATA) of generic_osync_inode()
   calls to write data inode.
 - Ext2_readpage() returns an error code.
 - Allocation of working area even when readonly mount.
 - Clear dirty bit of buffers after uncompress in ext2_readpage.
 - Unlock page after free buffers in error case in ext2_readpage.

  If someone is interested by this version of the patch,
Let me know, I will mail it.

  Feel free to contat me if you have some questions.

  Have fun.


--
-----------------------------\--------------------------\
Denis RICHARD                 \ ALCATEL Business Systems \
mailto:dri@sxb.bsf.alcatel.fr / Tel: +33(0)3 90 67 69 36 /
-----------------------------/--------------------------/


ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
