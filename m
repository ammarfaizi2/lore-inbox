Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271626AbRHPTf0>; Thu, 16 Aug 2001 15:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271627AbRHPTfS>; Thu, 16 Aug 2001 15:35:18 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:62169 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271626AbRHPTfB>;
	Thu, 16 Aug 2001 15:35:01 -0400
Date: Thu, 16 Aug 2001 20:35:12 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Andreas Dilger <adilger@turbolabs.com>, Steve Hill <steve@navaho.co.uk>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <212844030.997994112@[169.254.45.213]>
In-Reply-To: <20010816131112.V31114@turbolinux.com>
In-Reply-To: <20010816131112.V31114@turbolinux.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, since it IS critical that the ssh and VPN keys of a new system be
> very good, you could do something like run "bonnie++" on one of the new
> partitions, until you get enough entropy from block I/O completions.
...
> That said, there are still cases where network traffic _has_ to be enough
> for /dev/random, given that some firewalls (e.g. LRP) can run from only
> ramdisk, so have no other source of entropy than the network traffic.

It's a while since I looked, but I /thought/ entropy only came from
IDE (not for instance from SCSI, and certainly not when everything
is sitting in cache). I have a reasonably active mailserver (SCSI,
no k/b, no mouse, lots of RAM) which doesn't have enough entropy
to cope with SSL/TLS gracefully without relying on the network
traffic (i.e. behaves like it is ramdisk only).

--
Alex Bligh
