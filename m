Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVIEOug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVIEOug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVIEOug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:50:36 -0400
Received: from web51003.mail.yahoo.com ([206.190.38.134]:49311 "HELO
	web51003.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751279AbVIEOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:50:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6OVX6zHSFFHfu4JEfLTe98rJ0Yrx1urIwM5ZY0FylQ4T0m39yveZEdoOERhmepeTXswRZzMoLHakXjgKK8AtVzwt8ZdaPY2ldgWAqRNN95Fw2e2vEBXn/xKtBSjto4xJblyFiXmiMph6eveP726NFLMhNA5S2GT/vhob74+vxuQ=  ;
Message-ID: <20050905145030.90158.qmail@web51003.mail.yahoo.com>
Date: Mon, 5 Sep 2005 07:50:30 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: A Framework to automatically configure a Kernel
To: linux-kernel@vger.kernel.org
In-Reply-To: <431C3665.1090002@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Emmanuel Fleury <fleury@cs.aau.dk> wrote:

> Hi,
> 
> Ahmad Reza Cheraghi wrote:
> > 
> > I install right now a gcc 4.0 debian-packege on my
> > system and it still works. But I attached another
> > patch(I thik I did a mistake in the patch;-)).
> 
> Might be as well ! :)
> 
> But, I'll give it a try when you'll get this fixed !
> 
> >>2) Why is the target called "auconfig" and not
> >>"autoconfig" (just like
> >>we have a "menuconfig") ?
> > 
> > I thought that autoconfig will be to large for
> that
> > reaseon i called it auconfig.
> 
> Well, "menuconfig" is not that small either ! :)
> More explicit you are, better it is (within some
> reasonable limit).
> 
> > If you mean with your question that, why there are
> > less rules and why they don't get its information
> from
> > /sys or /proc etc. The answer will be:
> > 
> > Not that much. Most of the information will be
> > obtained from lspci and dmesg. The only one that
> gets
> > its inforamation directly from the I/O of the
> Hardware
> > is lspci. The other one like dmesg, /proc... anre
> > based on the Kernel installation and on drivers
> > installation. And it might happened that you won't
> > find Hardware that are on your system but aren't
> > installed from your Kernel.  
> 
> It was what I meant (sorry to have been unclear).
> 
> > But if you mean with your question, that why it
> dosn't
> > first of all create list of all of the information
> > given from /proc, ...? The answer is:
> > 
> > That the basic Idea of the framework is to extend
> it
> > easily. And the rules can be changed they way
> someody
> > knew its right and ok.
> 
> Ok.
> 
> Regards
> -- 
> Emmanuel Fleury
> 
> Assistant Professor          | Office: B1-201
> Computer Science Department, | Phone:  +45 96 35 72
> 23
> Aalborg University,          | Mobile: +45 26 22 98
> 03
> Fredriks Bajersvej 7E,       | E-mail:
> fleury@cs.aau.dk
> 9220 Aalborg East, Denmark   | URL:
> www.cs.aau.dk/~fleury
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
