Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144751AbRA2BWg>; Sun, 28 Jan 2001 20:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144788AbRA2BW1>; Sun, 28 Jan 2001 20:22:27 -0500
Received: from argo.starforce.com ([216.158.56.82]:61350 "EHLO
	argo.starforce.com") by vger.kernel.org with ESMTP
	id <S144751AbRA2BWM>; Sun, 28 Jan 2001 20:22:12 -0500
Date: Sun, 28 Jan 2001 20:22:08 -0500 (EST)
From: Derek Wildstar <dwild+linux_kernel@starforce.com>
X-X-Sender: <dwild@argo.starforce.com>
To: <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Dieter Nützel <Dieter.Nuetzel@hamburg.de>,
        Andrew Grover <andrew.grover@intel.com>
Subject: Re: Linux-2.4.1-pre11
In-Reply-To: <Pine.LNX.4.31.0101281845420.6761-100000@argo.starforce.com>
Message-ID: <Pine.LNX.4.31.0101282005111.6761-100000@argo.starforce.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Derek Wildstar wrote:

> OK, tried the patch and it worked, don't remember the exact errors with
> the .tar.gz, there were 7 or so undefined references.
>
> ACPI soft-hangs one step before (after looking at the non-debug source
> it may be the same place) it did last time, right after it prints:
>
> ACPI: Core Subsystem version [20010125]
>
> grabbing the debug version now to see if i can get more info.

OK, the debug version printed the following:

 tbxface-0089: ACPI Tables successfully loaded
Parsing Methods:................(more dots, i can count if needed)
173 Control Methods found and parsed (602 nodes total)
ACPI Namespace successfully loaded at root c042f718
ACPI: Core Subsystem version [20010125]
evxfevnt-0082: Transition to ACPI mode successful
Executing device _INI methods:........

The cursor stays at the end of the last line.

Let me know if there is anything you would like me to try.

-dwild

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
