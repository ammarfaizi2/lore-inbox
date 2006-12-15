Return-Path: <linux-kernel-owner+w=401wt.eu-S1753499AbWLOVnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbWLOVnx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbWLOVnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:43:53 -0500
Received: from smtp.saahbs.net ([70.235.213.234]:34731 "HELO smtp.saahbs.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753499AbWLOVnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:43:53 -0500
Date: Fri, 15 Dec 2006 15:43:51 -0600
From: Michal Sabala <lkml@saahbs.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 mmap hangs unrelated apps
Message-ID: <20061215214351.GB16106@prosiaczek>
Reply-To: Michael Sabala <lkml@saahbs.net>
References: <20061215023014.GC2721@prosiaczek> <1166199855.5761.34.camel@lade.trondhjem.org> <20061215175030.GG6220@prosiaczek> <1166211884.5761.49.camel@lade.trondhjem.org> <20061215210642.GI6220@prosiaczek> <1166217126.3365.230.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1166217126.3365.230.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006/12/15 at 15:12:06 Arjan van de Ven <arjan@infradead.org> wrote
> 
> > 
> > I do not have any indication that it is the server not responding. Other
> > applications which have NFS files open are continuing to work while in
> > this case XFree86 blocks.
> 
> just a strange question, but which video driver do you use in X? maybe
> that one is blocking say the pci bus or something...

Arjan,

The P3 box with nfs root uses the "ati" X11 driver with:
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64)

The P4 box with nfs /home uses the "i810" X11 driver with:
0000:00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated Graphics Device (rev 02)

Thanks, Michal

-- 
Michal "Saahbs" Sabala
