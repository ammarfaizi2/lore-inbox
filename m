Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130687AbRA3RLp>; Tue, 30 Jan 2001 12:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131033AbRA3RLh>; Tue, 30 Jan 2001 12:11:37 -0500
Received: from mlx3.unm.edu ([129.24.8.189]:43380 "HELO mlx3.unm.edu")
	by vger.kernel.org with SMTP id <S130687AbRA3RL2>;
	Tue, 30 Jan 2001 12:11:28 -0500
Date: Tue, 30 Jan 2001 10:11:19 -0700 (MST)
From: Todd <todd@unm.edu>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: <linux-kernel@vger.kernel.org>, <jmerkey@timpanogas.org>
Subject: Re: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
In-Reply-To: <20010130103208.C18047@vger.timpanogas.org>
Message-ID: <Pine.A41.4.31.0101301007490.37454-100000@aix01.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff,

On Tue, 30 Jan 2001, Jeff V. Merkey wrote:

> On 32 bit PCI, the average we are seeing going userpace -> userspace is
> 120-140 MB/S ranges in those systems that have a PCI bus with
> bridge chipsets that can support these data rates.
>
> That's 2 x G-Enet.

good numbers.  not really 2 x Gig-e, though, is it.  we're getting 993Mbps
(124Mb/s) on alteon acenic gig-e adapters on 32bit/66MHz pci machines.
i'm not saying that the nubmers aren't good or that the technology doesn't
sound promising (SCI is definitely cool stuff).  I'm just trying to put
the numbers in perspective and show that the targets should be higher.

i like your argument about cpu utilization. that's really the key.
anything that moves significant traffic and can reduce cpu utilization
will help enormously.  unfortunately, you've not posted any cpu numbers.

this is analogous to transmeta's complaint about battery life and
processor speed:  no one benchmarks both metrics at the same time.  if
they did, intel chips would not look nearly as good as they do.
similarly, most people are still not posting bandwidth numbers along with
cpu utilization numbers.  if they did, lots of fast networks would be less
appealing.

todd

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
