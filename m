Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266662AbRHPE1q>; Thu, 16 Aug 2001 00:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271430AbRHPE1g>; Thu, 16 Aug 2001 00:27:36 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:9989 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S266662AbRHPE1W>; Thu, 16 Aug 2001 00:27:22 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: WANTED: Re: VM lockup with 2.4.8 / 2.4.8pre8
In-Reply-To: <9lelsk$bri$1@ns1.clouddancer.com>
In-Reply-To: <Pine.LNX.4.10.10108151612000.9584-100000@athena.intergrafix.net> <20010815193521.4DDE8783F5@mail.clouddancer.com> <9lelsk$bri$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010816042734.D3E7C783F5@mail.clouddancer.com>
Date: Wed, 15 Aug 2001 21:27:34 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>> 
>> >I also propose to half badness of processes with pid < 1000 - those
>> >processes are usually also important, because they are called during
>> >boot-time and they usually handle important system affairs.
>> 
>> 
>> The belief that boot started processes remain under a pid < 1000 is
>> flawed.  Simple example: the postfix mail server.
>> 
>
>agreed, but FWIW my postfix master daemon is pid 434


Ah, yes that reminds me that when you take down a service and then
start it again, you lose that nice low pid.  FWIW, my master is 23034
now.  As D Ford stated, paying attention to pid value is not useful.


-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."

