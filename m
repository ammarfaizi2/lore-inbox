Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVBWDjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVBWDjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 22:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVBWDjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 22:39:46 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:3814 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261403AbVBWDjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 22:39:41 -0500
Date: Wed, 23 Feb 2005 00:39:03 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Message-Id: <200502230339.j1N3d3Re028586@laptop11.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Subject: Duplicate definition on NR_OPEN!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is defined in:

include/linux/limits.h:#define NR_OPEN          1024
include/linux/fs.h:#define NR_OPEN (1024*1024)  /* Absolute upper limit on fd num */

One is surely wrong?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
