Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275382AbSIUBFS>; Fri, 20 Sep 2002 21:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275416AbSIUBFR>; Fri, 20 Sep 2002 21:05:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:59912
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S275382AbSIUBFQ>; Fri, 20 Sep 2002 21:05:16 -0400
Date: Fri, 20 Sep 2002 18:06:58 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Rhoads, Rob" <rob.rhoads@intel.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project 
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0A53899F@orsmsx108.jf.intel.com>
Message-ID: <Pine.LNX.4.10.10209201753310.25090-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

My opinion only, and you may think it "stinks" ... oh well.

Obvious this is a way for the telecom folks to get something for free that
really should be paid for by funding the project with CASH.  Or funding
(a) startup(s) related to generating such support.

Regardless, it takes (fill in the blank) to boldly ask people to add APIs
for an industry who is only interested in using and not contributing.
Prove that all the stuff which is going to be plugged into these
security-hole^Wbug-generators^Wfeatures will be scheduled for open source.
Or this another attempt to try and take over the license and shove BSD
down the piles?

Pointed Blunt Raw, but nice.

Regards,

Andre Hedrick
LAD Storage Consulting Group

PS: I see a lot of "wants", are there any "gives" ?


On Fri, 20 Sep 2002, Rhoads, Rob wrote:

> 
> Project Announcement:
> --------------------
> We've started a new project on sourceforge.net w/ focus 
> on hardening Linux device drivers for highly available 
> systems. This project is being worked on with folks from 
> OSDL's CGL and DCL projects as well.
> 
> Initially we've created a specification, a few kernel modules
> that implement a set of driver programming interfaces, and
> a sample device driver that demonstrates those interfaces.
> 
> We are actively soliciting involvement with others in the 
> Linux developer community. We need your help to make this 
> project relevant and useful. 

We need your CAPITAL to pay for our TIME.

> Below I've included an overview of the hardened driver project. 
> By no means is this complete or final. It's just our initial
> attempt at defining what is meant by the term hardened driver
> and the areas we want to focus on.

Great, do they serve the needs of more than "INTEL"?

> For additional info, please checkout the links at the bottom 
> of this message and the Hardened Drivers web site at 
> http://hardeneddrivers.sf.net.
> 
> 
> Hardened Driver Project Overview:
> --------------------------------
> Device drivers have traditionally been a significant source 
> of software faults. For this reason, they are of key concern
> in improving the availability and stability of the operating
> system. A critical element in creating Highly Available (HA)
> environment is to reduce the likelihood of faults in key 
> drivers, a methodology called driver hardening. 
> 
> A device driver is typically implemented with emphasis on 
> the proper operation of the hardware. Attention to how it 
> will function in the event of hardware faults is often 
> minimal. Hardened drivers, on the other hand, are designed
> with the assumption that the underlying hardware that they
> control will fail. They need to respond to such failures by
> handling faults gracefully, limiting the impact on the overall
> system. Hardened device drivers must continue to operate when 
> the hardware has failed (e.g. allow device fail-over), and 
> must not allow the propagation of corrupt data from a failed 
> device to other components of the system.
> 
> Hardened device drivers must also be active participants in 
> the recovery of detected faults, by locally recovering them or
> by reporting them to higher-level system management software 
> that subsequently instructs the driver to take a specific 
> action.
> 
> The goal of a hardened driver is to provide an environment 
> in which hardware and software failures are transparent to 
> the applications using their services, where possible. The 
> way to effectively achieve this goal is to analyze a 
> driver's software design and implement appropriate changes
> to improve stability, reliability and availability, and 
> to provide instrumentation for management middleware.
> 
> We believe that improving driver stability and reliability 
> includes such measures as ensuring that all wait loops are
> limited with a timeout, validating input and output data and
> structuring the driver to anticipate hardware errors. 
> Improving availability includes adding support for device
> hot swapping and validating the driver with fault injection.
> Instrumentation for management middleware includes functions
> such as reporting of statistical indicators and logging of 
> pertinent events to enable postmortem analysis in the event
> of a failure.
> 
> To minimize instability contributed by device drivers and to 
> enhance the availability of HA systems, we've attempted to 
> define a set of requirements that a device driver should 
> adhere to in order to be considered a hardened driver. We 
> then define different hardening traits and the required 
> programming interfaces to support these hardening traits.
> 
> We've identified four areas in which drivers can be hardened:
> o Hardening with code robustness
> o Hardening with event logging
> o Hardening with diagnostics
> o Hardening with resource monitoring and statistics
> 
> We've also identified some key areas we feel are most critical
> to overall system stability and plan to focus initial hardening 
> efforts on drivers for network interface cards, physical storage, 
> and logical storage.
> 
> Project Links:
> -------------
> o The Driver Hardening website:  
>   http://hardeneddrivers.sourceforge.net
> 
> o The SourceForge project related info:
>   http://sourceforge.net/projects/hardeneddrivers
> 
> o Hardened Drivers Mailing List Info (subscribe here):
>   http://lists.sourceforge.net/mailman/listinfo/hardeneddrivers-discuss
> 
> 
> +=+=+
> Rob Rhoads                     mailto:rob.rhoads@intel.com
> Staff Software Engineer        office: 503-677-5498
> Telecom Software Platforms
> Intel Communications Group
> 
> This email message solely contains my own personal views, and not
> necessarily those of my employer.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


