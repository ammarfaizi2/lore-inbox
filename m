Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbTIEACi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTIEACi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:02:38 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:56053 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261353AbTIEACh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:02:37 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Wes Felter <wesley@felter.org>, linux-kernel@vger.kernel.org
Date: Thu, 4 Sep 2003 16:59:20 -0700 (PDT)
Subject: Re: Remote SCSI Emulation
In-Reply-To: <3F57CC2E.2030708@vgertech.com>
Message-ID: <Pine.LNX.4.44.0309041656240.18624-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Nuno Silva wrote:

> Wes Felter wrote:
> > On Wed, 03 Sep 2003 20:38:14 +0000, Muthian S wrote:
> >
> >>Certain SCSI adapters like the Adaptec AHA 29160 are reportedly capable of
> >>acting as a target and can receive SCSI commands from initiators.  Such an
> >>adapter can be used to facilitate remote SCSI emulation by a PC.
> >>For instance, if two PCs have the adapter, the two adapters can be
> >>directly connected by a SCSI bus and the second PC can in effect serve as
> >>an "emulated SCSI disk".  Such a setup is extremely helpful in various
> >>scenarios.
> >
> >
> > Search the archives/Web for "SCSI target", "LinuxDisk", etc. There are
> > plenty of half-finished implementations of this.
> >
>
> Another, more generic, solution is "ip over scsi":
>
> http://www.google.com/search?q=%22ip+over+scsi%22

Actually, ip over scsi cannot accomplish the goal listed above.

what is beeing looked for here is the scsi equivalent of the USB 'gadget'
driver, letting linux be at the slave end of things as well as the master.

does anyone have an idea why *BSD was able to do this, but all the linux
projects seem to get stuck half-finished? is this just added complexity
due to the large number of linux scsi drivers or is there something deeper
in the system?

David Lang
