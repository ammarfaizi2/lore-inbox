Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRDKXbZ>; Wed, 11 Apr 2001 19:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133001AbRDKXbP>; Wed, 11 Apr 2001 19:31:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4881 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132691AbRDKXbG>; Wed, 11 Apr 2001 19:31:06 -0400
Subject: Re: CML2 1.0.0 release announcement
To: esr@thyrsus.com
Date: Thu, 12 Apr 2001 00:33:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hch@caldera.de (Christoph Hellwig),
        davej@suse.de (Dave Jones), linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net,
        esr@snark.thyrsus.com (Eric S. Raymond)
In-Reply-To: <20010411191940.A9081@thyrsus.com> from "esr@thyrsus.com" at Apr 11, 2001 07:19:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nU6n-0007po-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A multiple-apex tree also tends to pull the configuration questions downwards
> from policy (e.g "Parallel-port support?") towards hardware-specific,
> platform-specific questions ("Atari parallel-port hardware?")  By designing
> the configuration rules for CML2 as a single-apex tree, I'm trying to
> move the questions upwards and have derivations in the rules file handle
> distributing that information to a lower level.

Ok I see where you are going with that argument. However when you parse all
the existing Config.in files into a tree you can see those properties by 
looking from any node back to its dependancies

