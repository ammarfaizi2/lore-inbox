Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVGLAdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVGLAdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 20:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVGLAb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 20:31:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31697 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262293AbVGLAbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 20:31:04 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <42D2D912.3090505@nortel.com>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <20050709203920.394e970d.diegocg@gmail.com>
	 <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay>
	 <1121113532.2383.6.camel@mindpipe>  <42D2D912.3090505@nortel.com>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 20:30:59 -0400
Message-Id: <1121128260.2632.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 14:39 -0600, Chris Friesen wrote:
> Lee Revell wrote:
> 
> > Tickless + sub HZ timers is a win for everyone, the multimedia people
> > get better latency, and the laptop people get to run longer.
> 
> IIRC it's not a win for many systems.  Throughput goes down due to timer 
> manipulation overhead.

Makes sense.  Anyway, this whole thread has been pretty hand wavey, I
propose that until we see some numbers from the HZ=250 advocates, we
leave the default alone.

Lee

