Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319244AbSIFQB7>; Fri, 6 Sep 2002 12:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319247AbSIFQB6>; Fri, 6 Sep 2002 12:01:58 -0400
Received: from ns.censoft.com ([208.219.23.2]:40858 "EHLO ns.censoft.com")
	by vger.kernel.org with ESMTP id <S319244AbSIFQB5>;
	Fri, 6 Sep 2002 12:01:57 -0400
Date: Fri, 6 Sep 2002 10:00:08 -0600
From: Jordan Crouse <jordanc@censoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: g4465018@pirun.ku.ac.th, linux-kernel@vger.kernel.org
Subject: Re: VIA82cxxx sound problem
Message-Id: <20020906100008.0bbc9894.jordanc@censoft.com>
In-Reply-To: <1031327595.9945.50.camel@irongate.swansea.linux.org.uk>
References: <Pine.GSO.4.44.0209061822580.1094-100000@pirun.ku.ac.th>
	<20020906092705.7a746d39.jordanc@censoft.com>
	<1031327595.9945.50.camel@irongate.swansea.linux.org.uk>
Organization: Century Software
X-Mailer: Sylpheed version 0.8.2claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually the audio hasnt changed between the Red Hat tree and that one.
> There is very little via audio support in Linux. Running the vanilla
> 2.4.19 versus RH 2.4.18-3 isnt going to help and is going to introduce
> all the bugs Red Hat fixed that are still working there way in post
> 2.4.19

Hmm...  a quick diff shows that you are quite right.  However the "SG stopped or paused" messages disappeared on my box as soon as I replaced 2.4.18-3 with the latest 2.4.18-pre10-acX tree, so I assumed that somewhere the appropriate tweeks had been made.

Though I did have to move to ALSA later on because of issues with the generic AC97 chip on my motherboard, and everything is working great now.  Perhaps you can try that instead?

Jordan

