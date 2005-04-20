Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVDTA1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVDTA1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 20:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVDTA1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 20:27:36 -0400
Received: from alog0079.analogic.com ([208.224.220.94]:19378 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261189AbVDTA1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 20:27:33 -0400
Date: Tue, 19 Apr 2005 20:26:24 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Chris Friesen <cfriesen@nortel.com>
cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL violation by CorAccess?
In-Reply-To: <42659620.5050002@nortel.com>
Message-ID: <Pine.LNX.4.61.0504192015590.20917@chaos.analogic.com>
References: <20050419175743.GA8339@beton.cybernet.src>
 <20050419182529.GT17865@csclub.uwaterloo.ca> <Pine.LNX.4.61.0504191516080.18402@chaos.analogic.com>
 <42656319.6090703@nortel.com> <Pine.LNX.4.61.0504191741190.19956@chaos.analogic.com>
 <42659620.5050002@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Chris Friesen wrote:

> Richard B. Johnson wrote:
>
>> No. Accompany it with a written offer to __provide__ the source
>> code for any GPL stuff they used (like the kernel or drivers).
>> Anything at the application-level is NOT covered by the GPL.
>> They do not have to give away their trade-secrets.
>
> GPL'd applications would still be covered by the GPL, no?
>

You mean like `ls` and `init` ??? Sure. I don't think any serious
embedded stuff would use that, though. Typically an embedded
system would start with a new application called 'init'. It
wouldn't use a SYS-V startup and certainly wouldn't have a shell.
The new init would do everything including mounting any file-
systems and initializing networking all by itself without
any help from the usual applications. It might fork-off a few
different tasks to handle different things. For instance,
the system shown probably handles the furnace and air-conditioner
as a separate task. The shades and blinds are probably another
and, certainly, communicating with the robot that mows the lawn
would require a separate task just to handle GPS.

> If I buy their product, I should be able to ask them for the source to
> all GPL'd entities that are present in the system, including the kernel,
> drivers, and all GPL'd userspace apps.
>
> Any *new* apps that they wrote they would of course be free to keep private.
>

Yep.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
