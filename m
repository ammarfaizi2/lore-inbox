Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVKVQfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVKVQfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbVKVQfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:35:30 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:60689 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964988AbVKVQfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:35:11 -0500
Message-ID: <438348BB.1050504@argo.co.il>
Date: Tue, 22 Nov 2005 18:35:07 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: jgarzik@pobox.com, jonsmirl@gmail.com, benh@kernel.crashing.org,
       alan@lxorguk.ukuu.org.uk, airlied@gmail.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <20051121225303.GA19212@kroah.com>	<20051121230136.GB19212@kroah.com>	<1132616132.26560.62.camel@gaston>	<21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>	<1132623268.20233.14.camel@localhost.localdomain>	<1132626478.26560.104.camel@gaston>	<9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>	<43833D61.9050400@argo.co.il>	<20051122155143.GA30880@havoc.gtf.org>	<43834400.3040506@argo.co.il> <20051122172650.72f454de.diegocg@gmail.com>
In-Reply-To: <20051122172650.72f454de.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 16:35:09.0711 (UTC) FILETIME=[B42619F0:01C5EF82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:

>And no, windows drivers don't work well enought in windows
>(try enabling the /3GB switch in your box and check how many drivers
>break...)
>  
>
I don't have a Windows box, but I'm quite sure Windows (without the more 
esoteric switches) is quite stable, even in SMP. The '95 and NT 4.0 days 
are gone. Give the drivers the environment they like (mangle the 
addresses if necessary, single thread them, allow them larger stacks, 
whatever it takes) and they will work well. Put them in userspace if 
you're paranoid or isolate them using binary translation.

 From this discussion, it looks like the choices of the future are 
Windows drivers or serial terminals. Excuse me now while I look for my 
null-modem cable.
