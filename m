Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277775AbRJIPeJ>; Tue, 9 Oct 2001 11:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277774AbRJIPdt>; Tue, 9 Oct 2001 11:33:49 -0400
Received: from ns.suse.de ([213.95.15.193]:56072 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277775AbRJIPdr>;
	Tue, 9 Oct 2001 11:33:47 -0400
Date: Tue, 9 Oct 2001 17:34:13 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Thomas Hood <jdthood@mail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: sysctl interface to bootflags?
In-Reply-To: <1002640876.1103.21.camel@thanatos>
Message-ID: <Pine.LNX.4.30.0110091731480.31520-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Oct 2001, Thomas Hood wrote:

> Hi.  I looked at your code and I saw that it depended
> on ACPI.  Since ACPI doesn't work on my machine, I
> thought I should look for another solution.  However,

Huh ? Read the code again.
Its no more dependant upon ACPI than bootflag.c is.
The bootflag is pointed at by an ACPI table.
The code I wrote functions /exactly/ the same on
a kernel with APM, ACPI or NO power management.

> Alan now tells me that what I want to do can already
> be done via /dev/nvram.

My code _is_ using /dev/nvram !

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

