Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314303AbSDRLAm>; Thu, 18 Apr 2002 07:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314307AbSDRLAl>; Thu, 18 Apr 2002 07:00:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55565 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314303AbSDRLAl>; Thu, 18 Apr 2002 07:00:41 -0400
Subject: Re: SSE related security hole
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 18 Apr 2002 12:18:34 +0100 (BST)
Cc: dledford@redhat.com (Doug Ledford), jh@suse.cz,
        linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de, ak@suse.de,
        pavel@atrey.karlin.mff.cuni.cz
In-Reply-To: <20020418072615.I14322@dualathlon.random> from "Andrea Arcangeli" at Apr 18, 2002 07:26:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16y9vu-0004PJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This mean the mmx isn't really backwards compatible and that's
> potentially a problem for all the legacy x86 multiuser operative
> systems.  That's an hardware design bug, not a software problem.  In
> short running a 2.[02] kernel on a MMX capable CPU isn't secure, the
> same potentially applies to windows NT and other unix, no matter of SSE.

That was my initial reaction but when I reread the documentation the 
Intel folks are actually saying even back in Pentium MMX days that it isnt
guaranteed that the FP/MMX state are not seperate registers
