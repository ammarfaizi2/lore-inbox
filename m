Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTIPQBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 12:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbTIPQBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 12:01:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:29115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261956AbTIPQAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 12:00:42 -0400
Date: Tue, 16 Sep 2003 08:57:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Ramon Casellas <casellas@infres.enst.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bug/Oops Power Management with linux-2.6.0-test5-mm2
In-Reply-To: <Pine.LNX.4.56.0309161431230.11872@gandalf.localdomain>
Message-ID: <Pine.LNX.4.33.0309160856390.958-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> echo -n mem > /sys/power/state
> 
> PM: Preparing system for suspend
> Stopping tasks: ========================================================================|
> hda: start_power_step(step: 0)
> hda: start_power_step(step: 1)
> hda: complete_power_step(step: 1, stat: 50, err: 0)
> hda: completing PM request, suspend
> PM: Entering state.
> Back to C!
> zapping low mappings.
> PM: Finishing up.
> PCI: Setting latency timer of device 0000:00:1f.5 to 64
> hda: Wakeup request inited, waiting for !BSY...
> e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
> hda: start_power_step(step: 1000)
> hda: completing PM request, resume
> Restarting tasks... done
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
> MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
> Bank 1: e200000000000005
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
> 
> The only problem now is that if I suspend, when resuming, neither the
> mouse nor the NIC works, but it's getting much better.
> 
> 
> with 
> echo -n disk > /sys/power/state
> 
> Stopping tasks: ===================================================================
>  stopping tasks failed (1 tasks remaining)
>  Restarting tasks...<6> Strange, artsd not stopped
>   done

Excuse my confusion, but is the machine suspending or is it returning 
immediately to the command line? 

Thanks,


	Pat


