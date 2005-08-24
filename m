Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVHXRLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVHXRLa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVHXRLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:11:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45017 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751218AbVHXRL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:11:29 -0400
Date: Wed, 24 Aug 2005 18:14:33 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Kumar Gala <galak@freescale.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       parisc-linux@parisc-linux.org, matthew@wil.cx
Subject: Re: [parisc-linux] [PATCH 07/15] parisc: remove use of asm/segment.h
Message-ID: <20050824171433.GD4645@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net> <Pine.LNX.4.61.0508241154290.23956@nylon.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508241154290.23956@nylon.am.freescale.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 11:55:30AM -0500, Kumar Gala wrote:
> Removed asm-parisc/segment.h as its not used by anything.

Did you already remove all the uses outside the parisc-specific bits of
the tree, eg ISDN, media/video/, sound/oss/, etc?

If so, ACK, otherwise, NAK.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
