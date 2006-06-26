Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWFZLoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWFZLoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWFZLod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:44:33 -0400
Received: from main.gmane.org ([80.91.229.2]:27058 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750760AbWFZLod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:44:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Subject: alloc_pages error
Date: Mon, 26 Jun 2006 12:43:56 +0100
Organization: ISR/IST
Message-ID: <e7oh9s$sme$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gtisr.isr.ist.utl.pt
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under stressful conditions, I got the following dmesg mensages, repeatedly:

__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process python

(and for other processes)

however, the memory did not seem full:

             total       used       free     shared    buffers     cached
Mem:        904148     547464     356684          0      23068      56648
-/+ buffers/cache:     467748     436400
Swap:      1052632     234388     818244

The kernel is vanilla version 2.4.32.

What is going on here?

Cheers,

Rodrigo

-- 

*** Rodrigo Martins de Matos Ventura <yoda@isr.ist.utl.pt>
***  Web page: http://www.isr.ist.utl.pt/~yoda
***   Teaching Assistant and PhD Student at ISR:
***    Instituto de Sistemas e Robotica, Polo de Lisboa
***     Instituto Superior Tecnico, Lisboa, PORTUGAL
*** PGP fingerprint = 0119 AD13 9EEE 264A 3F10  31D3 89B3 C6C4 60C6 4585

