Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWBFRI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWBFRI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWBFRI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:08:59 -0500
Received: from chello212017098056.surfer.at ([212.17.98.56]:33288 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id S932208AbWBFRI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:08:58 -0500
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200602102007.k1AK7BQ22111@hofr.at>
Subject: -fverbose-asm suggestion
To: linux-kernel@vger.kernel.org
Date: Fri, 10 Feb 2006 21:07:11 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI !

Its a trivial change to the top level Makefile

  CFLAGS_KERNEL   = -fverbose-asm

that would make the output of commands like:

  make kernel/sched.s

quite a lot more readable when decoding oops messages. 
There should be no arch dependencies as far as I know. So is there 
any reason why -fverbose-asm is not on by default in CFLAGS_KERNEL
or was it just not yet suggested ?

hofrat
