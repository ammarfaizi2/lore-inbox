Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262515AbREVHzT>; Tue, 22 May 2001 03:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbREVHzJ>; Tue, 22 May 2001 03:55:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10253 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262515AbREVHyu>; Tue, 22 May 2001 03:54:50 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: matthew@wil.cx (Matthew Wilcox)
Date: Tue, 22 May 2001 08:49:04 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), matthew@wil.cx (Matthew Wilcox),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        viro@math.psu.edu (Alexander Viro),
        alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz (Pavel Machek),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        clausen@gnu.org (Andrew Clausen), bcrl@redhat.com (Ben LaHaise),
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20010522021815.M23718@parcelfarce.linux.theplanet.co.uk> from "Matthew Wilcox" at May 22, 2001 02:18:15 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1526ue-0001WY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For _devices_, though?  I don't expect my mouse to work if gpm and xfree
> both try to consume device events from the same filp.  Heck, it doesn't
> even work when they try to consume events from the same inode :-)  I think
> this is a reasonable restriction for the class of devices in question.

Not really. Think about basic things like full duplex audio with two threads

