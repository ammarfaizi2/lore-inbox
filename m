Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129880AbRA3RHf>; Tue, 30 Jan 2001 12:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbRA3RHZ>; Tue, 30 Jan 2001 12:07:25 -0500
Received: from mlx3.unm.edu ([129.24.8.189]:16992 "HELO mlx3.unm.edu")
	by vger.kernel.org with SMTP id <S129880AbRA3RHI>;
	Tue, 30 Jan 2001 12:07:08 -0500
Date: Tue, 30 Jan 2001 10:07:07 -0700 (MST)
From: Todd <todd@unm.edu>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: <linux-kernel@vger.kernel.org>, <jmerkey@timpanogas.org>
Subject: Re: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
In-Reply-To: <20010130101958.A18047@vger.timpanogas.org>
Message-ID: <Pine.A41.4.31.0101301004290.37454-100000@aix01.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

folx,

On Tue, 30 Jan 2001, Jeff V. Merkey wrote:
> What numbers does G-Enet provide
> doing userspace -> userspace transfers, and at what processor
> overhead?

using stock 2.4 kernel and alteon acenic cards with stock firmware we're
seeing 993 MBps userspace->userspace (running netperf UDP_STREAM tests,
which run as userspace client and server) with 88% CPU utilization.

Using a modified version of the firmware that we wrote we're getting
993Mbps with 55% CPU utilization.

> I posted the **ACCURATE** numbers from my test, but I did clarify that I
> was using a system with a limp PCI bus.
>
> Jeff

i appreciate that.  i'm just trying to figure out why the numbers are so
low compared to the network speed you mentioned.

todd

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
