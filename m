Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293196AbSDMSqS>; Sat, 13 Apr 2002 14:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSDMSqS>; Sat, 13 Apr 2002 14:46:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54022 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293196AbSDMSqR>; Sat, 13 Apr 2002 14:46:17 -0400
Subject: Re: linux as a minicomputer ?
To: gilbertd@treblig.org (Dr. David Alan Gilbert)
Date: Sat, 13 Apr 2002 20:03:28 +0100 (BST)
Cc: vojtech@suse.cz (Vojtech Pavlik), linux-kernel@vger.kernel.org
In-Reply-To: <20020411170910.GS612@gallifrey> from "Dr. David Alan Gilbert" at Apr 11, 2002 06:09:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16wSo4-0000wD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 3d), USB, and hack the X servers not to switch consoles, and take
> > keyboard input from /dev/input/event devices. But that's still far from
> > the desired state of things.
> 
> Oh how annoying - where do they get knotted up? I'd presumed this was
> the whole point of the busid spec in the config file.

It depends whether there are overlapping resources and the like. You can
make it work but its less trivial than it seems if you have cards that
have to be mapped into the VGA space to do certain operations
