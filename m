Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132796AbRDQRs6>; Tue, 17 Apr 2001 13:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132798AbRDQRss>; Tue, 17 Apr 2001 13:48:48 -0400
Received: from isunix.it.ilstu.edu ([138.87.124.103]:33288 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S132796AbRDQRsg>; Tue, 17 Apr 2001 13:48:36 -0400
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200104171617.LAA06660@isunix.it.ilstu.edu>
Subject: Re: [PATCH] Process pinning
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 17 Apr 2001 11:17:26 -0500 (CDT)
Cc: npollitt@engr.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <m14nIRX-001RovC@mozart> from "Rusty Russell" at Apr 11, 2001 09:05:47 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> disallowed CPU on which it is already running.  And even a non-RT
> process will stick on its disallowed CPU as long as nothing else runs
> there.

are we going to keep the cpus_allowed API?  If we want the (IMHO) more
flexible sysmp() API - I'll finish the 2.4 port.  If we are going to keep
cpus_allowed - I'll just abandon pset and sysmp.

Personally, I like sysmp() and the pset tools better, perhaps with a /proc
extension to it.


