Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313451AbSDGTon>; Sun, 7 Apr 2002 15:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313452AbSDGTom>; Sun, 7 Apr 2002 15:44:42 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24072 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313451AbSDGTol>; Sun, 7 Apr 2002 15:44:41 -0400
Subject: Re: Two fixes for 2.4.19-pre5-ac3
To: jaharkes@cs.cmu.edu (Jan Harkes)
Date: Sun, 7 Apr 2002 21:01:47 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020407194032.GA15051@ravel.coda.cs.cmu.edu> from "Jan Harkes" at Apr 07, 2002 03:40:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uIrD-0006bm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Either add getpag/newpag natively (good for yearly flamefests in
> linux-kernel), or the more generic task-ornaments so I can make a
> trivial module that adds /dev/pag, semantics could be as simple as
> reading returns the current pag, and writing adds a new pag as a
> task-ornament.

Oh look, more dirt is falling out now we shook the tree a little. I have
zero problems with the PAG. We also need an luid and some other related things
in the future to do strict resource management on big systems (think of it
in this case as an accounting charge code)
