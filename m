Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289824AbSAOXLR>; Tue, 15 Jan 2002 18:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290267AbSAOXLH>; Tue, 15 Jan 2002 18:11:07 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:44815 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289824AbSAOXKu>;
	Tue, 15 Jan 2002 18:10:50 -0500
Date: Tue, 15 Jan 2002 15:07:21 -0800
From: Greg KH <greg@kroah.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Autoconfiguration: Original design scenario
Message-ID: <20020115230721.GA29020@kroah.com>
In-Reply-To: <3C4401CD.3040408@debian.org> <20020115105733.B994@flint.arm.linux.org.uk> <3C442395.8010500@debian.org> <20020115183432.GC27059@kroah.com> <20020115133130.A3197@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115133130.A3197@thyrsus.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 18 Dec 2001 20:22:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 01:31:30PM -0500, Eric S. Raymond wrote:
> Greg KH <greg@kroah.com>:
> > Giacomo, please, please, please, just use the info in the
> > MODULE_DEVICE_TABLE entries for your autoconfigure program.
> 
> Giacomo will probably answer definitively, but I believe he is already
> generating all of the PCI, PNP, and module probes by script.  We're planning
> to ship the probe table generator with a future CML2 version.

Why not just have the probe table automatically generated against the
current kernel?  That way you don't have to release a new version of the
autoconfigure program for _every_ kernel version (including the -pre
versions.)

I feel like I'm sounding like a broken record here...

greg k-h
