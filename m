Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262497AbRENVPw>; Mon, 14 May 2001 17:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262498AbRENVPm>; Mon, 14 May 2001 17:15:42 -0400
Received: from titan.mcs.anl.gov ([140.221.16.102]:64388 "EHLO
	titan.mcs.anl.gov") by vger.kernel.org with ESMTP
	id <S262497AbRENVPd>; Mon, 14 May 2001 17:15:33 -0400
Date: Mon, 14 May 2001 16:15:12 -0500
To: linux-kernel@vger.kernel.org
Subject: TCP capture effect (was Re: Linux TCP impotency)
Message-ID: <20010514161509.B3192@titan.mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Samuel Meder <meder@mcs.anl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:

> > causes the earlier started one to survive and the later to
> > starve. Running bcp instead of the second (which uses UDP) at
> > 11000 bytes per second caused the utilization in both directions
> > to go up nearly to 100%.  
> > 
> > Is this a normal TCP stack behaviour? 
>
> Yes. TCP is not fair. Look up 'capture effect' if you want to know more. 


I'm seeing a similar effect myself. When I use all my available sdsl
bandwidth (say doing a bulk data transfer), DNS lookups will often
time out. This is with the default buffer settings/2.4.4. 
I'm curious about this effect so I've been trying to find information
on this and while I can find lots of information on the Ethernet
capture effect there doesn't seem to be anything on the TCP capture
effect. Could someone point me at an explanation of this effect?


Thanks

/Sam Meder


