Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUEaSIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUEaSIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 14:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264721AbUEaSIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 14:08:38 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:19859 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264717AbUEaSIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 14:08:37 -0400
Date: Mon, 31 May 2004 20:08:21 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
Message-ID: <20040531180821.GC5257@louise.pinerecords.com>
References: <40BA2213.1090209@pobox.com> <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl> <s5g8yf9ljb3.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5g8yf9ljb3.fsf@patl=users.sf.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is really very simple.  If you move a disk from a machine with a
> different BIOS and you preserve the partition table geometry, you will
> NEVER be able to install Windows on the drive.  If you partition a
> blank drive and use the wrong geometry, you will NEVER be able to
> install Windows on the drive.

I don't quite believe this.  AFAICT the Windows 2000/XP install program will
succeed no matter what, the only problem is with getting the dirty thing to
boot AFTER install has completed.  If it craps out, boot off the install
CD to the repair console prompt, run fixboot/fixmbr and all should be swell.
If you need dual boot, you can go ahead and reinstall lilo/grub at this point.
The one scenario unfixable without a hex editor that I know of is installing
Windows on a partition that was created using mkdosfs -F 32 (and even that
will sometimes work).

-- 
Tomas Szepe <szepe@pinerecords.com>
