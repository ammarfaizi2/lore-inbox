Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263504AbREYDMy>; Thu, 24 May 2001 23:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263505AbREYDMn>; Thu, 24 May 2001 23:12:43 -0400
Received: from COR0ppp-101.uc.infovia.com.ar ([209.13.178.101]:48389 "EHLO
	Ono-Sendai.linux.hack") by vger.kernel.org with ESMTP
	id <S263504AbREYDMi>; Thu, 24 May 2001 23:12:38 -0400
Date: Fri, 25 May 2001 00:14:54 -0300 (ART)
From: <bruj0@securityportal.com.ar>
To: <linux-kernel@vger.kernel.org>
Subject: PATCH: "Kernel Insider" (security optimization)
Message-ID: <Pine.LNX.4.31.0105250006440.1495-100000@Ono-Sendai.linux.hack>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, i wrote a modification for kernels 2.4.x, actually it can be
lodaded as a module and its not intrusive. I would love to get you opinions,
critics, flames about it. Plase CC: me becouse im not in the list. thanx
The whole package with a intructions is at
http://securityportal.com.ar/files/insider-1.6.tar.gz

This is the description:
INSIDER
-------
Its a linux kernel modification, that allows to decide wich uid, pid or
file can open a tcp socket in listening state.
The changes to the kernel are really insignificant, only to export 2
variables.
When  a program tries to open a port it first makes a md5 checksum
of the file and compares it with the config list then it compares the user
id and finally the pid.
The policy is to "DENY" everything that is not in the allowed list.

Bruj0

