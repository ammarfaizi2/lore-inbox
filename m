Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbRF0PIe>; Wed, 27 Jun 2001 11:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263089AbRF0PIY>; Wed, 27 Jun 2001 11:08:24 -0400
Received: from eax.student.umd.edu ([129.2.236.2]:39182 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S262997AbRF0PIQ>; Wed, 27 Jun 2001 11:08:16 -0400
Date: Wed, 27 Jun 2001 10:08:15 -0500 (EST)
From: Adam <adam@eax.com>
X-X-Sender: <adam@eax.student.umd.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.x series and mm 
Message-ID: <Pine.LNX.4.33.0106271008010.16671-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,
	I have question. I have box with kernel 2.2.17pre15
	and 128mb memory.

	now on this box I have apache server which is serving 205 mb
	of data.

	AFAICT this casues all current processes swapped out every
	so often in favor of putting all data to be served into
	file buffers, making a box pain for interative use.

	what are my options here for a) tuning up box w/out rebooting
	or b) some "better" 2.2.x kernel.

	I'm fairly sure it is the file buffers as the apache is already
	reniced to 20, it is got max 50 processes and each of processes is
	limited to like 1.5mb of size via ulimit.

-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers



