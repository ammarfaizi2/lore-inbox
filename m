Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWB1WW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWB1WW2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWB1WW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:22:28 -0500
Received: from ns.suse.de ([195.135.220.2]:29317 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932525AbWB1WW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:22:28 -0500
From: Andi Kleen <ak@suse.de>
To: dtor_core@ameritech.net
Subject: Re: Status of X86_P4_CLOCKMOD?
Date: Tue, 28 Feb 2006 23:22:01 +0100
User-Agent: KMail/1.9.1
Cc: "Matt Mackall" <mpm@selenic.com>, "Dave Jones" <davej@redhat.com>,
       "Adrian Bunk" <bunk@stusta.de>, davej@codemonkey.org.uk,
       "Zwane Mwaikambo" <zwane@commfireservices.com>,
       "Samuel Masham" <samuel.masham@gmail.com>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       cpufreq@lists.linux.org.uk
References: <20060222024438.GI20204@MAIL.13thfloor.at> <20060228213428.GA31044@isilmar.linta.de> <d120d5000602281339h777a9b73nb95bf6b6b5ee90c9@mail.gmail.com>
In-Reply-To: <d120d5000602281339h777a9b73nb95bf6b6b5ee90c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602282322.03316.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 22:39, Dmitry Torokhov wrote:
> On 2/28/06, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > On Tue, Feb 28, 2006 at 03:26:32PM -0600, Matt Mackall wrote:
> > > > So even if the battery lasts longer, you don't have anything of it, 'cause
> > > > the CPU can even compute _less_ in this longer time-span. Remember that
> > > > idling doesn't count...
> > >
> > > Which is different from other power-saving modes how? If it means I
> > > can read my email longer on the plane, it's a power-saving mode.
> >
> > But you can't... [*]
> ...
> > [*] unless the idling algorithm is broken and does not enter C2-type idle
> > states.
> 
> Or box does not support anything but C1.

There are quite advanced forms of C1 around.
And I would expect even old style dumb C1 to save more than throttling.

-Andi
