Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132790AbRDKSaA>; Wed, 11 Apr 2001 14:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132803AbRDKS3s>; Wed, 11 Apr 2001 14:29:48 -0400
Received: from m307-mp1-cvx1c.col.ntl.com ([213.104.77.51]:23425 "EHLO
	[213.104.77.51]") by vger.kernel.org with ESMTP id <S132761AbRDKS3U>;
	Wed, 11 Apr 2001 14:29:20 -0400
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'John Fremlin'" <chief@bandits.org>, "'Pavel Machek'" <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE822@orsmsx35.jf.intel.com>
From: John Fremlin <chief@bandits.org>
Date: 11 Apr 2001 19:29:05 +0100
In-Reply-To: "Grover, Andrew"'s message of "Wed, 11 Apr 2001 10:06:52 -0700"
Message-ID: <m2d7aj9tou.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" <andrew.grover@intel.com> writes:

[...]

> > > > +		printk ("acpi: Power button pressed!\n");
> > 
> > [...]
> > 
> > > > +		printk("acpi: Sleep button pressed!\n");
> > 
> > Do you think you could keep the above part of the patch? It would be
> > nice to know how much of ACPI was actually working ;-)

> I'm hesitant to do this, since 1) You can put those printk's in
> yourself to find out if your particular system is working and 2) You
> can just cat /proc/sys/event, hit a button, and you should see
> output if it works.

Hmm. Pavel Machek could hardly be described as a newbie at hacking
stuff, and yet he says, "I hunted bug for few hours, thinking that
kernel does not get the event at all."

The printks are certainly clearer than cat'ing some binary garbage to
the console and will help out the casual user who doesn't want to
recompile kernel and reboot just to discover that the damn thing
doesn't work.

[...]

-- 

	http://www.penguinpowered.com/~vii
