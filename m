Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129982AbRAaFNx>; Wed, 31 Jan 2001 00:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130235AbRAaFNn>; Wed, 31 Jan 2001 00:13:43 -0500
Received: from [64.160.188.242] ([64.160.188.242]:46085 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129982AbRAaFNf>; Wed, 31 Jan 2001 00:13:35 -0500
Date: Tue, 30 Jan 2001 21:12:48 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA VT82C686X
In-Reply-To: <Pine.LNX.4.21.0101302204570.19724-100000@winds.org>
Message-ID: <Pine.LNX.4.21.0101302105170.4439-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Jan 2001, Byron Stanoszek wrote:

> (unless you're overclocking). Setting it to 66 will cause the VIA driver to
> believe your PCI bus is running at 66MHz and will program the IDE controller to
> run at half the speed to maintain 33MHz. In reality, your controller now runs
> at 16.

I removed the ide and ata setting. System is running stably as in no
kernel crashes, but I am getting daemon and shell crashes. With this
current kernel I've had 1 kernel crash in about 3 hours as compared to 1
every 10 or 15 minutes. Crash, reboot, 10 minutes or so crash, reboot. ect
ect.

I'm wanting to test something else out. I'm wondering if there isn't some
hardware issue with the RAM. This particular board will do 1GB of PC133,
or 2.5GB of PC100. I'm wondering if there isn't something wrong with how
it reads the speed and the appropriate limitation. It's running stably if
I only run 768MB of PC133 RAM. But if I run a solid 1GB of PC133 I get
segfaults and sig11 crashes constantly. All the RAM has been
professionally tested and certified.

Any clues would be appreciated. 

David


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
