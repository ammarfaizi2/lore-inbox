Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270820AbTHKBMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 21:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270817AbTHKBMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 21:12:15 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:46979
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270822AbTHKBMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 21:12:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: sis fb 2.4/2.6 boot issue
Date: Mon, 11 Aug 2003 11:17:40 +1000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308111117.40659.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Building a kernel with the sis acceleration and fb modules built in instead of 
as modules makes the machine always boot in a framebuffer mode on a sis 630 
chipset. This happens even if I specify vga=normal with my bootloader. While 
this isn't a major problem in itself; when X starts up, because some memory 
is apparently already allocated to the FB, the colours are all a little off. 
Building it as modules does not have this issue, and building vesa fb into 
the kernel also does not have this problem.

Con

