Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271104AbUJUXWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271104AbUJUXWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271093AbUJUXSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:18:20 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:2785 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S271036AbUJUXN1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:13:27 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Hibernation and time and dhcp
Date: Fri, 22 Oct 2004 01:13:16 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200410202045.24388.cijoml@volny.cz> <200410211531.50238.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410211531.50238.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410220113.16593.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne èt 21. øíjna 2004 14:31 Denis Vlasenko napsal(a):
> On Wednesday 20 October 2004 21:45, Michal Semler wrote:
> > Hi guys,
> >
> > with 2.6.9 hibernation to disk finally works! Thanks
> > To ram it still don't work, system starts with lcd disabled - but it is
> > another story.
> >
> > I have now this problem - when I hibernate and then system is started up
> > in other company, it don't update time and shows still for example 14:00
> > - when I rehibernate for example in 20:00 - could you ask bios for
> > current time? It's better to have bad time about few seconds instead of
> > hours.
> >
> > Same problem with dhcp - it should ask for IP when rehibernate.
>
> These should be handled in userspace. You can put together
> some simple shell script to do it with (hwclock or ntpdate) and [u]dhcp*
> --
> vda

Yes, it's possible, but many programs crashes when time is moved about hours 
or days. And till time they will be repaired, we should ask for time BIOS to 
have little time difference.

Michal
