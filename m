Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318785AbSHWMuw>; Fri, 23 Aug 2002 08:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318786AbSHWMuw>; Fri, 23 Aug 2002 08:50:52 -0400
Received: from cttsv008.ctt.ne.jp ([210.166.4.137]:7626 "EHLO
	cttsv008.ctt.ne.jp") by vger.kernel.org with ESMTP
	id <S318785AbSHWMuw>; Fri, 23 Aug 2002 08:50:52 -0400
Message-Id: <200208231254.VAA20879@cttsv008.ctt.ne.jp>
Date: Fri, 23 Aug 2002 14:45:33 +0900
To: root@chaos.analogic.com, sanket rathi <sanket@linuxmail.org>
CC: linux-kernel@vger.kernel.org
From: Kerenyi Gabor <wom@tateyama.hu>
Subject: Re: interrupt handler
Organization: Tateyama Hungary Ltd.
X-Mailer: Opera 5.12 build 932
X-Priority: 3 (Normal)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8/23/2002 9:17:07 PM, "Richard B. Johnson" <root@chaos.analogic.com> wrote:

>On Fri, 23 Aug 2002, sanket rathi wrote:
>
>> hi,
>> Can i use spin lock in the interrupt handler for a singlre processor
>> machine. because books says u can not use locks but spin lock is some
>> thing diffrent 
>> 
>> thanks in advance
>> 
>> --Sanket
>> ---------
>
>Interrupts default to OFF within an interrupt handler. Given this,
>why would you use a spin-lock within the ISR on a single-processor
>machine?

Because he would like to write a code that can be run on a computer
with more than one CPU. 

Anyway, do anybody know what kind of advantages/disadvantages I can get
if I don't disable interrupts at all in my driver? Even if I have to use a circular
buffer or anything else? Is it worth trying to find such a solution or is it
a wasted time?

Gabor


