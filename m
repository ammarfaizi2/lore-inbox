Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262311AbTCRKgM>; Tue, 18 Mar 2003 05:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262313AbTCRKgM>; Tue, 18 Mar 2003 05:36:12 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:62980 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262311AbTCRKgL>; Tue, 18 Mar 2003 05:36:11 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303181048.h2IAmurm000784@81-2-122-30.bradfords.org.uk>
Subject: Re: Linux 2.5.65
To: cat@zip.com.au (CaT)
Date: Tue, 18 Mar 2003 10:48:56 +0000 (GMT)
Cc: zippel@linux-m68k.org, torvalds@transmeta.com, hch@lst.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030318103557.GF504@zip.com.au> from "CaT" at Mar 18, 2003 09:35:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The help and the tristate seems to indicate that I should be able to
> > > compile it into the kernel, but menuconfig wont let me. This is
> > > presumably due to the dependancy but is it right?
> > 
> > Yes, this was the behaviour of the old config tools, which was restored 
> > with 2.5.65. This means 'm' is a marker that this thing works only as a 
> > module.
> > If you want the other behaviour, that it can only be built as a module in 
> > a modular kernel, but compile it into a nonmodular kernel, you can use "m 
> > || !MODULES" instead.
> 
> Ahhh. So if I want module support but not use it as a module then I'm
> SOL?

vi .config

John.
