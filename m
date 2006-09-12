Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWILNah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWILNah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 09:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWILNah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 09:30:37 -0400
Received: from holoclan.de ([62.75.158.126]:29369 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1030211AbWILNag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 09:30:36 -0400
Date: Tue, 12 Sep 2006 15:28:38 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ltp] 2.6.18-rc6, SATA, resume from RAM
Message-ID: <20060912132838.GQ7767@gimli>
Mail-Followup-To: linux-thinkpad@linux-thinkpad.org,
	linux-kernel@vger.kernel.org
References: <87u03dcmfc.fsf@pereiro.luannocracy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u03dcmfc.fsf@pereiro.luannocracy.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, Sep 12, 2006 at 08:13:43AM -0400, David Abrahams
	wrote: > > Since installing a 2.6.18-rc6 kernel, my Thinkpad T60P's SATA
	hard > drive doesn't seem to spin up when resuming from a
	suspend-to-RAM. Am > I missing something obvious, is this a kernel bug,
	or am I missing > something less-obvious ;-)? [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 08:13:43AM -0400, David Abrahams wrote:
> 
> Since installing a 2.6.18-rc6 kernel, my Thinkpad T60P's SATA hard
> drive doesn't seem to spin up when resuming from a suspend-to-RAM.  Am
> I missing something obvious, is this a kernel bug, or am I missing
> something less-obvious ;-)?

I don't know if your T60 has the same issue like my X60s but I had to patch
my kernel to get a proper resume

I applied forrest zhauo's set of ahci patches to 2.6.18-rc5

you find those patches here:
http://marc.theaimsgroup.com/?l=linux-ide&m=115277002327654&w=2

maybe they find there way into the kernel sometime :-)

greets
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
