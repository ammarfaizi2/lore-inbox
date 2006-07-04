Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWGDLIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWGDLIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWGDLIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:08:43 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:10483 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751182AbWGDLIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:08:42 -0400
Date: Tue, 4 Jul 2006 13:08:40 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neil Brown <neilb@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Tomasz Torcz <zdzichu@irc.pl>, Helge Hafting <helgehaf@aitel.hist.no>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
Message-ID: <20060704110840.GK3305@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Neil Brown <neilb@suse.de>,
	Arjan van de Ven <arjan@infradead.org>,
	Tomasz Torcz <zdzichu@irc.pl>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <1151964720.16528.22.camel@localhost.localdomain> <17577.43190.724583.146845@cse.unsw.edu.au> <1152001067.28597.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152001067.28597.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11-2006-06-13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

> This makes LVM, remapping, checksumming and the like all naturally slip
> out of the fs but not into the block layer.

enhance LVM and have the functionality for all available fs. I think
this is the right way to go with checksums and fault tolerance but not
with snapshots.

        Thomas
