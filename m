Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVIUNya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVIUNya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 09:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVIUNya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 09:54:30 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8677 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750948AbVIUNy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 09:54:29 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Robert.Boermans@uk.telex.com
Subject: Re: Bogomips on AMD X2 (was Re:)
Date: Wed, 21 Sep 2005 16:53:17 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <OF73453AE5.CDE706CC-ON80257083.004ACF55-80257083.004B7A0F@telex.com>
In-Reply-To: <OF73453AE5.CDE706CC-ON80257083.004ACF55-80257083.004B7A0F@telex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211653.17999.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I noticed that the bogomips results for the two cores on my machine are 
> > consistently not the same, the second one is always reported slightly 
> > faster, it's a small difference and I saw the same in a posted dmesg 
> from 
> > somebody else on the list. Which made me wonder: 
> 
> I guess it's a cache warming effect. Please show the numbers.
>
> Probably not, got this one from a web site, and on this one the first core 
> seems to be faster (can't check my own machine it's off and at home and 
> I'm at work.) The difference I get is similar, but always with the second 
> one faster. It's the same when using cat on /proc/cpuinfo. Oh and I saw it 
> on 2.6.11 and 2.6.12 as supplied with fedora core 4 myself.
> 
> Calibrating delay using timer specific routine.. 4014.73 BogoMIPS 
> (lpj=8029470)
...
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 4005.37 BogoMIPS 
> (lpj=8010751)

Why do you think it cannot be a cache warming effect?
--
vda
