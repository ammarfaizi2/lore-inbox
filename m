Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbTDXAoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTDXAoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:44:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40418 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264355AbTDXAoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:44:14 -0400
Date: Wed, 23 Apr 2003 17:45:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>, Pavel Machek <pavel@ucw.cz>
cc: "Grover, Andrew" <andrew.grover@intel.com>, Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <1605730000.1051145146@flay>
In-Reply-To: <1051142550.4306.10.camel@laptop-linux>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com><20030424000344.GC32577@atrey.karlin.mff.cuni.cz> <1051142550.4306.10.camel@laptop-linux>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't believer I've ever seen things get OOM killed. Instead, page
> cache is discarded until things do fit.

What happens if user allocated pages are filling up all the space,
not page cache? Trust me, it happens ;-)

M.

