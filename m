Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbTAUKrj>; Tue, 21 Jan 2003 05:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTAUKrj>; Tue, 21 Jan 2003 05:47:39 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:55185
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267011AbTAUKr2>; Tue, 21 Jan 2003 05:47:28 -0500
Date: Tue, 21 Jan 2003 05:55:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Grover <andrew.grover@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: Ask devices to powerdown before S3 sleep
In-Reply-To: <20030121104601.GB24349@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0301210554050.2653-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Pavel Machek wrote:

> Hi!
> 
> > > SUSPEND_RESUME phase is needed for turning off IO-APIC. [I believe
> > > SUSPEND_DISABLE should be so simple that errors just should not be
> > > there, and besides we would not know how to safely enable devices from
> > > such weird state, anyway]. Please apply,
> > 
> > panic() is a bit on the extreme side no? I know diddly about ACPI and 
> > the current code, but can't you check for _PS3 methods or _S3D mappings 
> > for your devices before hand to be certain that the system can even go 
> > down to S3 somewhat reliably?
> 
> At this point, you already DISABLED half of devices, and you don't
> even know *which* ones. You can't just send them ENABLE and hope it
> works.

I meant checking before you even attempt starting the process of doing S3.

	Zwane
-- 
function.linuxpower.ca

