Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266595AbRGGWOx>; Sat, 7 Jul 2001 18:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266598AbRGGWOn>; Sat, 7 Jul 2001 18:14:43 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:64263 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S266595AbRGGWOa>;
	Sat, 7 Jul 2001 18:14:30 -0400
Date: Sun, 8 Jul 2001 00:14:24 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: miket@bluemug.com, linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Message-ID: <20010708001424.B10370@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com> <9i6oga$jk1$1@pccross.average.org> <3B46F3CE.9002ABAB@mandrakesoft.com> <20010707144032.C19529@mayotte> <20010707235329.A10256@pcep-jamie.cern.ch> <20010707150422.D19529@mayotte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010707150422.D19529@mayotte>; from miket@bluemug.com on Sat, Jul 07, 2001 at 03:04:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Touloumtzis wrote:
> > Yes that would work, and it would work on machines with less RAM too.
> > You would want to remove the cramfs filesystem code when you're done though.
> 
> Some of the files in the boot time FS would need to
> be kept around, such as the ACPI code, right?

Perhaps.  They could be copied to a ramfs by the user-space code :-)

On this theme, it's just occured to me that the module loader could be
taught to map ramfs pages directly to module code/data space.  That
would save a little memory.

-- Jamie
