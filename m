Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTLESDD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbTLESDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:03:03 -0500
Received: from magic.adaptec.com ([216.52.22.17]:13797 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S264255AbTLESDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:03:01 -0500
Date: Fri, 05 Dec 2003 11:07:24 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: "A. S." <lukels@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Compiling SCSI driver (Adaptec aic7xxx)
Message-ID: <2494970000.1070647644@aslan.btc.adaptec.com>
In-Reply-To: <BAY9-F11LdP4GLqfjE70001985b@hotmail.com>
References: <BAY9-F11LdP4GLqfjE70001985b@hotmail.com>
X-Mailer: Mulberry/3.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Compiling SCSI driver (Adaptec aic7xxx):
> 
> aicasm_symbol.c:39: db1/db.h: No such file or directory
> 
> No "db.h" was found in the source code.

The assembler required DB 1.85 support to work.  You'll find references
to DB in the symbol table routines.

--
Justin

