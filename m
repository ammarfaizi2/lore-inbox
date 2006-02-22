Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWBVUXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWBVUXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbWBVUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:22:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:9396 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422664AbWBVUWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:22:25 -0500
X-Authenticated: #428038
Date: Wed, 22 Feb 2006 21:22:19 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Douglas Gilbert <dougg@torque.net>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lsscsi-0.17 released
Message-ID: <20060222202219.GA25121@merlin.emma.line.org>
Mail-Followup-To: Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
	Douglas Gilbert <dougg@torque.net>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <43FBA4CD.6000505@torque.net> <m34q2r93q2.fsf@merlin.emma.line.org> <43FC7CCB.4090508@torque.net> <20060222160602.GB17473@merlin.emma.line.org> <43FC90E4.10805@torque.net> <20060222163426.GG28587@parisc-linux.org> <20060222171438.GA20272@kroah.com> <20060222180015.GB20880@merlin.emma.line.org> <20060222183226.GA12542@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222183226.GA12542@kroah.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Greg KH wrote:

> On Wed, Feb 22, 2006 at 07:00:15PM +0100, Matthias Andree wrote:

> > OK, just post an announcement to l-k when sysfs has stabilized enough to
> > be worth bothering.
> 
> Um, this was a "bugfix".

Granted.

> The kernel was creating multiple symlinks with
> the same name, in the same directory, pointing to different locations.
> How do you expect us to fix that in a format that does not change the
> name of the symlink?
> 
> People sure are grumpy this morning...

If you say so. I'd call it pure pragmatism: if the sysfs interface
still changes every other week or so, it's just annoying to chase these
changes in applications, so it seems just practical to wait until all
the bug fixes that require interface changes are in and the rate of
incompatible changes is well below 2/year -- and all the interesting
stuff is there.

-- 
Matthias Andree
