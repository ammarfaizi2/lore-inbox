Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUJVVJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUJVVJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUJVVHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:07:17 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:30223 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267743AbUJVVAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:00:08 -0400
Date: Fri, 22 Oct 2004 21:59:52 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Cc: marcelo.tosatti@cyclades.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch 1/2] cciss: cleans up warnings in the 32/64 bit conversions
In-Reply-To: <20041022183057.GA23032@beardog.cca.cpqcorp.net>
Message-ID: <Pine.LNX.4.58L.0410222157080.22781@blysk.ds.pg.gda.pl>
References: <20041021211718.GA10462@beardog.cca.cpqcorp.net>
 <Pine.LNX.4.58L.0410220054010.15504@blysk.ds.pg.gda.pl>
 <20041022183057.GA23032@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, mikem wrote:

> >  These constructs (casts as lvalues) are deprecated with GCC 3.4 (a
> > warning is triggered) and no longer supported with 4.0.  Please consider
> > rewriting -- you'll probably need an auxiliary variable.
[...]
> Is this documented somewhere?

 Sure:

http://gcc.gnu.org/gcc-3.4/changes.html

http://gcc.gnu.org/gcc-4.0/changes.html

Plus reported zillion of times here and elsewhere.

  Maciej
