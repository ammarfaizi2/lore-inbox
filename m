Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132594AbRDKO4u>; Wed, 11 Apr 2001 10:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132592AbRDKO4k>; Wed, 11 Apr 2001 10:56:40 -0400
Received: from m292-mp1-cvx1a.col.ntl.com ([213.104.69.36]:34176 "EHLO
	[213.104.69.36]") by vger.kernel.org with ESMTP id <S132591AbRDKO4Y>;
	Wed, 11 Apr 2001 10:56:24 -0400
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE817@orsmsx35.jf.intel.com>
From: John Fremlin <chief@bandits.org>
Date: 11 Apr 2001 15:56:12 +0100
In-Reply-To: "Grover, Andrew"'s message of "Tue, 10 Apr 2001 10:05:13 -0700"
Message-ID: <m2k84rh4dv.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 "Grover, Andrew" <andrew.grover@intel.com> writes:

> This is not correct, because we want the power button to be
> configurable.  The user should be able to redefine the power
> button's action, perhaps to only sleep the system. We currently
> surface button events to acpid, which then can do the right thing,
> including a shutdown -h now (which I assume notifies init).

That's just fine and dandy, but

[...]

> > +		printk ("acpi: Power button pressed!\n");

[...]

> > +		printk("acpi: Sleep button pressed!\n");

Do you think you could keep the above part of the patch? It would be
nice to know how much of ACPI was actually working ;-)

[...]

-- 

	http://www.penguinpowered.com/~vii
