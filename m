Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUHXSLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUHXSLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268147AbUHXSLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:11:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38818 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268146AbUHXSLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:11:15 -0400
Message-ID: <412B84B8.1060600@pobox.com>
Date: Tue, 24 Aug 2004 14:11:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: hmh@debian.org
Subject: rng-tools updated
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just posted version 2 of rng-tools at 
http://sourceforge.net/projects/gkernel/

This release fixes a problem related to 2.6.x kernels.

rng-tools is currently for users of hardware random number generators 
(RNGs), and the included daemon rngd fill the kernel entropy pool from 
userspace with the results of the output.

Future directions include:
* support for VIA 'xcrypt' instruction in userspace, avoiding the need 
for a kernel driver
* multithreaded daemon
* additional entropy sources besides the dedicated h/w RNG


