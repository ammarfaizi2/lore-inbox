Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278591AbRKAJHq>; Thu, 1 Nov 2001 04:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278592AbRKAJHh>; Thu, 1 Nov 2001 04:07:37 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:21940 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S278591AbRKAJH0>; Thu, 1 Nov 2001 04:07:26 -0500
Date: Thu, 1 Nov 2001 10:06:37 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Juergen Hasch <Hasch@t-online.de>
Cc: linux-kernel@vger.kernel.org, J Sloan <jjs@pobox.com>
Subject: Re: Intel EEPro 100 with kernel drivers
Message-ID: <20011101100637.B20259@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <15yzpC-26N6dEC@fwd04.sul.t-online.com> <20011101090348.E2102@stud.ntnu.no> <15zDX1-1svMLQC@fwd03.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15zDX1-1svMLQC@fwd03.sul.t-online.com>; from Hasch@t-online.de on Thu, Nov 01, 2001 at 09:48:56AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Hasch:
> But your Rx_TCO_Packets counter is  1, so this may be related
> (I also got Rx overrun errors). It may be that your BMC receives the packet
> and simply chooses to ignore it because it is no valid server management 
> packet.
> Could you make another test and take a look at the eth0.info ?
> I could reproduce the problem when copying a large file over NFS, but not 
> when transferring it via ftp. Try this a few times.
> If you can reproduce you network card being stuck only when using NFS and 
> having Rx_TCO_Packets > 0 after it is stuck, this is it.
> Then you either need tu upgrade your BMC firmware or add another network card,
> which doesn't eat NFS packets.

I'm testing now, however, running eepro100-diag gave me some interessting
output:

Sleep mode is enabled.  This is not recommended. Under high load the card
may not respond to PCI requests, and thus cause a master abort.

How do I disable sleepmode? I've never even enabled it.

-- 
Thomas
