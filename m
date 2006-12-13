Return-Path: <linux-kernel-owner+w=401wt.eu-S932486AbWLMBiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWLMBiW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWLMBiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:38:22 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:35534 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932420AbWLMBiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:38:21 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 20:38:21 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Xc2X931ffcpVb9ZnDcixQ7/zjobw+smG/4kO/9ujegvTRDXcBwGktzxv5jBm58Vrl6HpR6vZCtilXcfJ/yNRM+TRvXqOaWl0Cg2FSez9gvC4sKTV5SxW4KD0lxsjnhI/pqlLEPYqGvJ+r2VJvW+a2D5d9qIrmHpq09W+AvF7sfM=  ;
X-YMail-OSG: fmgQznAVM1kWYbIcGSbQyXR48SOS_uEPr2tuO1dWpQ3BRIgtD_BvGMHMGPn3ODON.YTu9TevMWp5v11p43uAxqk0Z4hyCjDj_HevnEmkGnde009_Pc2JtSUDUlK7c5glqObQD5flsaZdJg--
From: David Brownell <david-b@pacbell.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch 2.6.19-git] RTC Kconfig sorted by type
Date: Tue, 12 Dec 2006 17:31:39 -0800
User-Agent: KMail/1.7.1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200612061652.45242.david-b@pacbell.net> <20061212230517.GA28443@stusta.de>
In-Reply-To: <20061212230517.GA28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612121731.40463.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +if RTC_CLASS != n
> > +
> 
> 
> if RTC_CLASS
> 
> 
> because otherwise

Thanks for the clarification.  I think Alessandro was going to
redo this one soon, since the Kconfig changed so much the patch
would no longer apply.  I trust he'll remember your comments!

- Dave
