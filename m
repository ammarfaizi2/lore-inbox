Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbUBWNcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUBWNcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:32:21 -0500
Received: from smtp9.wanadoo.fr ([193.252.22.22]:14149 "EHLO
	mwinf0903.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261848AbUBWNcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:32:19 -0500
Date: Mon, 23 Feb 2004 14:32:13 +0100
From: Lucas Nussbaum <lucas@lucas-nussbaum.net>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.3 still doesn't boot on UltraSparc I
Message-ID: <20040223133213.GA24179@blop.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163232.GA2107@blop.info>
Organisation: Lacking
X-PGP: http://www.lucas-nussbaum.net/pubkey.txt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As we reported in [1], Linux 2.6.(2|3) doesnt boot on sparc64. We traced the
problem back to some changes in arch/sparc64/kernel/head.S (2.6.3 does
boot with 2.6.1's head.S).

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=107643106916202&w=2

output :
Allocated 8 Megs of memory at 0x4000000 for kernel
Loaded kernel version 2.6.3    <--- SILO message
Illegal Instruction
{0} ok 

After a discussion with Ben Collins, it seems that only UltraSparc I are
affected. Could somebody check the new head.S's assembly code ? We are a
bit short here on sparc64 ASM...

Please tell us how we can help.

Thank you,
-- 
Lucas Nussbaum
Club GNU/Linux
ENSIMAG - Departement Telecommunications
