Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbTA3Ah6>; Wed, 29 Jan 2003 19:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTA3Ah6>; Wed, 29 Jan 2003 19:37:58 -0500
Received: from rose.csi.cam.ac.uk ([131.111.8.13]:62622 "EHLO
	rose.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266733AbTA3Ah5>; Wed, 29 Jan 2003 19:37:57 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, cw@f00f.org, bcrl@redhat.com
Subject: sys_sendfile64 not in Linux 2.4.21-pre4
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
From: John Fremlin <vii@users.sf.net>
In-Reply-To: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
 (Marcelo Tosatti's message of "Wed, 29 Jan 2003 04:24:20 GMT")
X-Home-Page: http://john.fremlin.de
Date: Thu, 30 Jan 2003 00:47:14 +0000
Message-ID: <86of5z5ur1.fsf@notus.ireton.fremlin.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Military
 Intelligence, i586-seventh-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why isn't sendfile64 included in 2.4.21-pre4? glibc 2.3 already
expects it, so programs with 64-bit off_t will not be able to use
sendfile otherwise. And the patch is IIUC very small . . .

