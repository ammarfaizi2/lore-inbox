Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292417AbSBPQZg>; Sat, 16 Feb 2002 11:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292415AbSBPQZS>; Sat, 16 Feb 2002 11:25:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7942 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292414AbSBPQZE>; Sat, 16 Feb 2002 11:25:04 -0500
Subject: Re: Disgusted with kbuild developers
To: esr@thyrsus.com
Date: Sat, 16 Feb 2002 16:38:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones),
        rml@tech9.net (Robert Love),
        arjan@pc1-camc5-0-cust78.cam.cable.ntl.com (Arjan van de Ven),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020216105425.A31986@thyrsus.com> from "Eric S. Raymond" at Feb 16, 2002 10:54:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16c7rR-0006Z5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jeff and Alan have put their finger neatly on one of the key bits CML2
> can do that CML1 cannot -- express cross-directory dependencies in
> such a way that the configurator can force side effects in both
> directions.  This is, in fact, the very rock on which my original
> attempt to save CML1 foundered after six weeks of effort.

You can force a side effect in both directions. The language provides the
information to do that, the current -toolset- can't handle this.

At any point you ask a question you can "wind back" and compute the set
of changes that are needed and re-ask only the needed questions.
