Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbRFNJ0k>; Thu, 14 Jun 2001 05:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbRFNJ0a>; Thu, 14 Jun 2001 05:26:30 -0400
Received: from babel.spoiled.org ([212.84.234.227]:36781 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S262242AbRFNJ0T>;
	Thu, 14 Jun 2001 05:26:19 -0400
Date: 14 Jun 2001 09:26:17 -0000
Message-ID: <20010614092617.12555.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: mozgy@hinet.hr (Mario Mikocevic)
Cc: linux-kernel@vger.kernel.org;, haberland@altus.de
Subject: Re: Need a helping hand (realproducer and radio device)
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <20010614093405.C6467@danielle.hinet.hr>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010614093405.C6467@danielle.hinet.hr> you wrote:
> Hi,
> 
> I have an Hauppauge WinTV/Radio card and I want to be able to use it's radio
> device as a source for live broadcast.
> 
> It's RH71 distro updated with mainstream 2.4.5 .
> 
> Radio device works fine on it's own meaning that I can tune the station and
> listen to it.
> 
> RealProducer (8.5) also works fine meaning that it encodes video inputs and Line-In
> input into realmedia stream just fine.
> 
> 
> The problem is that in startup realproducer mutes (IMO) or shuts down or something, that radio
> device on bt8x8 card and therefore no actual audio signal gets to Line-In resulting in no audio
> in realmedia stream.

I had a similar problem long time ago. The point is that the realproducer
mutes the recording source in the mixer. Try to reenable it using aumix or
a similar application.

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

