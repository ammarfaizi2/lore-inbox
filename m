Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTHUBHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 21:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbTHUBHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 21:07:47 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:62605
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id S262368AbTHUBHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 21:07:46 -0400
Message-ID: <3F441B60.9040404@tupshin.com>
Date: Wed, 20 Aug 2003 18:07:44 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6 -- gnome problem
References: <3F4268C1.9040608@redhat.com> <shszni499e9.fsf@charged.uio.no> <20030820192409.A2868@pclin040.win.tue.nl> <16195.49464.935754.526386@charged.uio.no> <20030820215246.B3065@pclin040.win.tue.nl> <3F441213.4060906@tupshin.com> <20030821023836.B3204@pclin040.win.tue.nl>
In-Reply-To: <20030821023836.B3204@pclin040.win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:

>On Wed, Aug 20, 2003 at 05:28:03PM -0700, Tupshin Harper wrote:
>
>  
>
>>This patch makes the previously posted test work for me, but I'm 
>>experiencing a differenct NFS regression between 2.4 and 2.6. Whatever 
>>locking method that gnome2 is using when running home directories over 
>>nfs is failing when the client is running 2.6.
>>Gnome reports that it failed to lock it's test file, and aborts.
>>It says that the error was "no locks available".
>>    
>>
>
>"Gnome" is not precise enough for me.
>If you have an explicit test program that works on 2.4 and fails
>on 2.6 and is not more than a single page in length, I wouldnt mind
>looking at it.
>
>  
>
Fair enough. I don't have such an explicit test at the moment, but I 
will talk to the gnome guys and see if I can come up with one. I was 
reporting what the gnome2 session-manager complains about, but 
comparable errors come from something as simple as gnome-terminal 
(simplest program I've seen that has the problem). FWIW, this is gnome 
2.2.2. I'll get back to you when I know more.

-Tupshin

