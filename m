Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbRLXV7O>; Mon, 24 Dec 2001 16:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285380AbRLXV7E>; Mon, 24 Dec 2001 16:59:04 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:60172 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S285369AbRLXV64>;
	Mon, 24 Dec 2001 16:58:56 -0500
Date: Mon, 24 Dec 2001 22:58:55 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Data sitting and remaining in Send-Q
Message-ID: <20011224225855.J2461@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011224211726.H2461@lug-owl.de> <1062462662.1009226676@[195.224.237.69]> <20011224213452.A7761@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011224213452.A7761@Marvin.DL8BCU.ampr.org>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-24 21:34:52 +0000, Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
wrote in message <20011224213452.A7761@Marvin.DL8BCU.ampr.org>:
> On Mon, Dec 24, 2001 at 08:44:37PM -0000, Alex Bligh - linux-kernel wrote:
> > If you have an L3 device (router etc.) in the middle, you can get
> > a similar effect if the device does not fragment data correctly
> > (for instance the Cisco into ip tunnels bug - now fixed I think),
> > or, if you are using PMTU discovery (probably), if some evil device,
> 
> Jan,
> do you have some DSL Modem in between?

Hi Thorsten!

No, it's not the famous MTU-too-large-and-a-lot-of-fragmentation-needed
problem. It was a broken NIC, unwilling to send frames > ~960 bytes...

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
