Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVBHT1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVBHT1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 14:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVBHT1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 14:27:16 -0500
Received: from chaos.sr.unh.edu ([132.177.249.105]:54462 "EHLO
	chaos.sr.unh.edu") by vger.kernel.org with ESMTP id S261636AbVBHT1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 14:27:14 -0500
Date: Tue, 8 Feb 2005 14:26:56 -0500 (EST)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: Matthew Wilcox <matthew@wil.cx>, Roman Zippel <zippel@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       <linux-kernel@vger.kernel.org>, <dholland@eecs.harvard.edu>
Subject: Re: [PATCH] Makefiles are not built using a Fortran compiler
In-Reply-To: <20050208192027.GA8360@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0502081423470.30718-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005, Sam Ravnborg wrote:

> The SCCS rules is the sole reason why -rR has not been enabled.

An easy way to make sure that the SCCS business is not a factor would be 
to explicitly put the SCCS rules into the Makefile -- it's just two lines.

This way one could easily make sure there are no other problems incurred 
(I wouldn't think so, but...), and tackle the SCCS/bk business later.

--Kai

