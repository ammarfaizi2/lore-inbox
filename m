Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268794AbTGJCwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 22:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268811AbTGJCwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 22:52:22 -0400
Received: from mailbox.ucsd.edu ([132.239.1.56]:13582 "EHLO mailbox4.ucsd.edu")
	by vger.kernel.org with ESMTP id S268794AbTGJCwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 22:52:11 -0400
Date: Wed, 9 Jul 2003 20:06:48 -0700
To: linux-kernel@vger.kernel.org
Subject: PCMCIA can't be probed during kernel loading????
Message-ID: <20030710030648.GA5066@cannon.ucsd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Yang Yang <yangyang@juggler.ucsd.edu>
X-Spamscanner: mailbox4.ucsd.edu  (v1.2 May 26 2003 01:55:38, -102.5/5.0 2.55)
X-MailScanner: PASSED (v1.2.7 73133 h6A36min084063 mailbox4.ucsd.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all:
	I am triying to get NFS mount root working on a DELL inspiron
	laptop, with only a PCMCIA card ( 3com589D ). I builtin the NFS_ROOT 
	support and hardware drivers into the kernel. Then booted the kernel
	but the eth0 is not discovered, and the messages show that cardbus
	can't probe any card. 

	I mean should the kernel be able to find the card itself and set it
	up , or does it need some user application ( like cardmgr ) to do it
	? if it's the latter case, basically means it's impossible to run a
	diskless station over NFS with only PCMCIA network card?

	thanks a lot

	Yang
