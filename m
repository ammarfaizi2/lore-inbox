Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272982AbTGaLjx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272456AbTGaLju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:39:50 -0400
Received: from mail2.qmul.ac.uk ([138.37.6.6]:10705 "EHLO mail2.qmul.ac.uk")
	by vger.kernel.org with ESMTP id S272982AbTGaLjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:39:22 -0400
Message-ID: <1059651493.3f28ffa5d6cd2@webmail.stu.qmul.ac.uk>
Date: Thu, 31 Jul 2003 12:38:13 +0100
From: ha0124@qmul.ac.uk
To: linux-kernel@vger.kernel.org
Subject: kernel panic with gzip and hpt370 raid
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 138.37.63.131
X-Sender-Host-Address: 138.37.100.211
X-QM-Scan-Accept: This message was accepted by ls_accept.so
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a HPT370 embedder ide raid controller. If I use the 2.4.21 kernel wich 
supports the mirroring features of this card, then my ADSL modem Alcatel)is not 
detected by the drivers (Avalible on source forge.)
I have sucesfully extracted the files from the 2.4.21 kernel and patched the 
2.4.18 kernel with this code. The seems to work fine and compiled without any 
probs.

The only problem is that during the tape backup routine each night a kernel 
panic occures when gzip is running. If I use bzip it works fine.

the obvious solution to this is if the bug preventing the 2.4.21 kernel from 
using the modem is fixed. I am using exactly the smae settings in the config 
file for both kernels so no items are missing that the drivers supports.


many Thanks

James Cronin


