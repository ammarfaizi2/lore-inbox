Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTJ3NLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTJ3NLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:11:41 -0500
Received: from shockwave.systems.pipex.net ([62.241.160.9]:46762 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262429AbTJ3NLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:11:40 -0500
From: Shaheed <srhaque@iee.org>
To: linux-kernel@vger.kernel.org
Subject: Re:WG:  EIO DM-8401H ATA133 IDE Controller Card ( Silicon Image Chip ?!?)
Date: Thu, 30 Oct 2003 13:12:52 +0000
User-Agent: KMail/1.5.93
Cc: michael@labuschke.de
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200310301312.52793.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Interestingly, EXACTLY the same thing happened to me. I actually bought a 
vanilla IDE controller for a spare disk, and in what showed up the 
documentation claimed it was a DM-8401R, but lspci shows what you see: and 
IT8212.

The answer was to get the good stuff from here:

http://www.iteusa.com/productInfo/Download.html#IT8212%20ATA133%20Controller

The driver install was a doddle (well documented, and easy to apply Mandrake 
9.1 instructions to 9.2). For heavens sake: these guys even provide the specs 
online. And the driver seems to work, though I am not stressing it.

Thanks, Shaheed
