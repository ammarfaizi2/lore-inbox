Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSETKrm>; Mon, 20 May 2002 06:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315855AbSETKrl>; Mon, 20 May 2002 06:47:41 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:16638
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S315842AbSETKrl>; Mon, 20 May 2002 06:47:41 -0400
Message-ID: <3CE8D44F.990C3091@eyal.emu.id.au>
Date: Mon, 20 May 2002 20:47:43 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: SO_REUSEADDR: broke between 2.4.17 and .18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server that uses SO_REUSEADDR. It used to work and nothing
changed in this area for a long while. A recent test fails with
"address already in use".

I just rebooted a few kernels and verified that:
	2.4.17 works OK.
	2.4.18 fails.
	2.4.19-pre8 fails.
	2.4.19-pre8-ac4 fails.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
