Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318746AbSG0Myf>; Sat, 27 Jul 2002 08:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318747AbSG0Myf>; Sat, 27 Jul 2002 08:54:35 -0400
Received: from oak.sktc.net ([208.46.69.4]:39949 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S318746AbSG0Mye>;
	Sat, 27 Jul 2002 08:54:34 -0400
Message-ID: <3D4298C6.9080103@sktc.net>
Date: Sat, 27 Jul 2002 07:57:42 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020714
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Rodland <arodland@noln.com>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: Speaker twiddling [was: Re: Panicking in morse code]
References: <20020727000005.54da5431.arodland@noln.com>	<200207270526.g6R5Qw942780@saturn.cs.uml.edu> <20020727015703.21f47a37.arodland@noln.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand the direction this discussion is taking.

Either you are trying to output the panic information with minimal 
hardware, and in a form a human might be able to decode, in which case 
the Morse option seems to me to be the best, or you are trying to panic 
in a machine readable format - in which case just dump the data out 
/dev/ttyS0 and be done with it!

To my way of thinking, the idea of the Morse option is that if an oops 
happens when you are not expecting it, and you haven't set up any 
equipment to help you, you still have a shot at getting the data.

Trying to dump the oops data out by some form of FSK in most cases seems 
silly - if you have taken the time to set up a microphone and decoder, 
why not just set up a serial terminal?

