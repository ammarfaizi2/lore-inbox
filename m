Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVAMUXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVAMUXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVAMTjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:39:05 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:63704 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261347AbVAMTfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:35:22 -0500
Date: Thu, 13 Jan 2005 11:35:16 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: "Allan B. Cruse" <cruse@cs.usfca.edu>, binutils@sources.redhat.com
Cc: gcc@gcc.gnu.org, GNU C Library <libc-alpha@sources.redhat.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Change i386 assembler/disassembler for SIB with INDEX==4
Message-ID: <20050113193516.GA441@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am proposing to change i386 assembler/disassembler for SIB with
INDEX==4

http://sources.redhat.com/bugzilla/show_bug.cgi?id=658

It will change the assembler output for (%ebx,[1248]). I am not too
worried about the disassembler output since assembler can't generate
SIB with INDEX==4 directly today. Any comments?


H.J.
