Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSGGWTx>; Sun, 7 Jul 2002 18:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSGGWTx>; Sun, 7 Jul 2002 18:19:53 -0400
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:6420 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316589AbSGGWTw>; Sun, 7 Jul 2002 18:19:52 -0400
Posted-Date: Sun, 7 Jul 2002 22:22:14 GMT
Date: Sun, 7 Jul 2002 23:22:10 +0100 (BST)
From: Riley Williams <rhw@InfraDead.Org>
Reply-To: Riley Williams <rhw@InfraDead.Org>
To: Justin Hibbits <jrh29@po.cwru.edu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Michael Elizabeth Chastain <mec@shout.net>
Subject: Re: Patch for Menuconfig script
In-Reply-To: <3D2793CB.90002@po.cwru.edu>
Message-ID: <Pine.LNX.4.21.0207072319440.9595-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin.

> This is just a patch to the Menuconfig script (can be easily adapted
> to the other ones) that allows you to configure the kernel without
> the requirement of bash (I tested it with ksh, in POSIX-only mode).  
> Feel free to flame me :P

Does it also work in the case where the current shell is csh or tcsh
(for example)? If not, you will need to replace the test for bash with a
test for bash or ksh or ... instead, as otherwise it will still fail.
Certainly on the systems I've used where bash isn't available, tcsh has
been far commoner than ksh.

Best wishes from Riley.

