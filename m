Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbREVPtE>; Tue, 22 May 2001 11:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261916AbREVPsy>; Tue, 22 May 2001 11:48:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16913 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261898AbREVPsn>; Tue, 22 May 2001 11:48:43 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: matthew@wil.cx (Matthew Wilcox)
Date: Tue, 22 May 2001 16:42:57 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), matthew@wil.cx (Matthew Wilcox),
        torvalds@transmeta.com (Linus Torvalds),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        viro@math.psu.edu (Alexander Viro), pavel@suse.cz (Pavel Machek),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        clausen@gnu.org (Andrew Clausen), bcrl@redhat.com (Ben LaHaise),
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20010522163830.O23718@parcelfarce.linux.theplanet.co.uk> from "Matthew Wilcox" at May 22, 2001 04:38:30 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152EJF-00025C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thats a bit pathetic. So I have to fill my app with expensive pthread locks
> > or hack all the drivers and totally change the multi-open sematics in the ABI
> huh?

For the sound. And remember each open of /dev/audio is a different channel
potentially (ie its a factory)

