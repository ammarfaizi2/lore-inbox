Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbTA3Sb1>; Thu, 30 Jan 2003 13:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbTA3Sb1>; Thu, 30 Jan 2003 13:31:27 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31368
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267577AbTA3Sb0>; Thu, 30 Jan 2003 13:31:26 -0500
Subject: Re: Linux 2.4.21-pre4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Davis <tadavis@lbl.gov>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3E39669F.20302@lbl.gov>
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
	 <3E384D41.9080605@lbl.gov>
	 <1043926998.28133.21.camel@irongate.swansea.linux.org.uk>
	 <3E395C30.6040903@lbl.gov>
	 <1043950661.31674.12.camel@irongate.swansea.linux.org.uk>
	 <3E396032.2000503@lbl.gov>
	 <1043951291.31674.17.camel@irongate.swansea.linux.org.uk>
	 <3E39669F.20302@lbl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043955332.31674.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 19:35:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 17:53, Thomas Davis wrote:
> 
> ie, it has a ac97 support in the driver, it calls ac97_probe_codec?
> 
> Is that enough or not?

The codec and the sound card are two seperate things. The FM801 
hardware has an AC97 digital interface that talks to a codec chip
of which there are a considerable number. Which one depends on
who made the specific board you have. The ac97 side isnt part
of the FM801 any more than a PC motherboard automatically
has an Intel CPU

