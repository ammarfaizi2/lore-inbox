Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281327AbRKQK53>; Sat, 17 Nov 2001 05:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281329AbRKQK5S>; Sat, 17 Nov 2001 05:57:18 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:53520 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281327AbRKQK5D>;
	Sat, 17 Nov 2001 05:57:03 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@caldera.de>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] mconfig 0.20 available 
In-Reply-To: Your message of "Fri, 16 Nov 2001 17:38:40 BST."
             <20011116173840.A15515@caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Nov 2001 21:56:51 +1100
Message-ID: <16782.1005994611@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001 17:38:40 +0100, 
Christoph Hellwig <hch@caldera.de> wrote:
>The mconfig release 0.20 is now available.
>
>Mconfig is a tool to configure the linux kernel, similar to
>make {menu,x,}config, but written in C and with a proper yacc
>parser.

Christoph, could you explain why this is being added now and how it
compares to CML1 and/or CML2?

kbuild 2.[45] is completely agnostic about how .config and autoconf.h
are built, the only requirement is that .config be internally
consistent before it goes into the main build phase.  I don't care how
.config is built, but I do want to understand why another version of
CML is being developed.

