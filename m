Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbUAZVFH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUAZVFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:05:06 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:13832 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265178AbUAZVFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:05:03 -0500
Subject: Re: Encrypted Filesystem
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Mark Borgerding <mark@borgerding.net>
Cc: Michael A Halcrow <mahalcro@us.ibm.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <40156546.1050809@borgerding.net>
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com>
	 <40156546.1050809@borgerding.net>
Content-Type: text/plain
Message-Id: <1075151094.809.11.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 26 Jan 2004 22:04:55 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-26 at 20:06, Mark Borgerding wrote:

> Have you given any thought to journalling? fscking? Can directory 
> contents be encrypted?  If so, what does the dir look like to others 
> (e.g. backup utils)
> 
> Per-file signatures will severely affect random access performance.  
> Changing 1 byte in a 1 GB file would require the whole thing to be reread.

What about calculating signatures on a per-block basis instead?

