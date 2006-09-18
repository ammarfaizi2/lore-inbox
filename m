Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751941AbWIRWAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbWIRWAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbWIRWAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:00:44 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:5043 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751211AbWIRWAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:00:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=KQCPtub6uEeYTotiMuwvZ3ITu47S61eqIpOGVzPAxziaYjgG9Vvhpn2VgbWymtiJWqkvhT0FmOc2q/1a2MuseDeN8FYv2cXDFrtAuDBinoVUAB28Qz7s/sBm2HqlDa/8FMNoqiuIPmvj27KyYPMNyxTJivv2iNWf4xlDrAxX+UQ=;
Date: Tue, 19 Sep 2006 02:00:38 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: Andi Kleen <ak@suse.de>, Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060918220038.GB14322@ms2.inr.ac.ru>
References: <4492D5D3.4000303@atmos.washington.edu> <200609181754.37623.ak@suse.de> <20060918162847.GA4863@ms2.inr.ac.ru> <200609181850.22851.ak@suse.de> <20060918211759.GB31746@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918211759.GB31746@tentacle.sectorb.msk.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Please think about it this way:
> suppose you haave a heavily loaded router and some network problem is to
> be diagnosed. You run tcpdump and suddenly router becomes overloaded (by
> switching to timestamp-it-all mode

I am sorry. I cannot think that way. :-)

Instead of attempts to scare, better resend original report,
where you said how much performance degraded, I cannot find it.

* I do see get_offset_pmtmr() in top lines of profile. That's scary enough.
* I do not undestand what the hell dhcp needs timestamps for.
* I do not listen any suggestions to screw up tcpdump with a sysctl.
  Kernel already implements much better thing then a sysctl.
  Do not want timestamps? Fix tcpdump, add an options, submit the
  patch to tcpdump maintainers. Not a big deal. 

Alexey
