Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292286AbSBBOa3>; Sat, 2 Feb 2002 09:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292287AbSBBOaJ>; Sat, 2 Feb 2002 09:30:09 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:31217 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S292286AbSBBO36>; Sat, 2 Feb 2002 09:29:58 -0500
Date: Sat, 2 Feb 2002 14:29:57 +0000 (GMT)
From: Matej Pfajfar <mp292@cam.ac.uk>
X-X-Sender: <mp292@orange.csi.cam.ac.uk>
To: <linux-kernel@vger.kernel.org>
Subject: PF_UNIX socket problem in 2.4
Message-ID: <Pine.SOL.4.33.0202021429060.6-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After upgrading to kernel 2.4.18pre7 (from 2.2.19), a recv() operation on
a UNIX socket returns 11 (EGAIN) even though the socket is blocking. My
code worked fine on 2.2.19.

I am doing some more debugging to see why this happens but I would like to
ask whether anyone else has had similar problems? Is this a known bug?
Thank you,

Matej

Matej Pfajfar
St John's College, University of Cambridge, UK

GPG Public Key @ http://matejpfajfar.co.uk/keys
Most people are good people, the rest of us are going to
run the world. -- badbytes



