Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132672AbRDKRJL>; Wed, 11 Apr 2001 13:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132670AbRDKRJE>; Wed, 11 Apr 2001 13:09:04 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:41953 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S132668AbRDKRIp>; Wed, 11 Apr 2001 13:08:45 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE822@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'John Fremlin'" <chief@bandits.org>
Cc: "'Pavel Machek'" <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: Let init know user wants to shutdown
Date: Wed, 11 Apr 2001 10:06:52 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hesitant to do this, since 1) You can put those printk's in yourself to
find out if your particular system is working and 2) You can just cat
/proc/sys/event, hit a button, and you should see output if it works.

Regards -- Andy

> From: John Fremlin [mailto:chief@bandits.org]

>  "Grover, Andrew" <andrew.grover@intel.com> writes:
> 
> > This is not correct, because we want the power button to be
> > configurable.  The user should be able to redefine the power
> > button's action, perhaps to only sleep the system. We currently
> > surface button events to acpid, which then can do the right thing,
> > including a shutdown -h now (which I assume notifies init).
> 
> That's just fine and dandy, but
> 
> [...]
> 
> > > +		printk ("acpi: Power button pressed!\n");
> 
> [...]
> 
> > > +		printk("acpi: Sleep button pressed!\n");
> 
> Do you think you could keep the above part of the patch? It would be
> nice to know how much of ACPI was actually working ;-)

