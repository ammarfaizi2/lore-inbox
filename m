Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423477AbWJZNCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423477AbWJZNCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423478AbWJZNCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:02:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:25729 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1423477AbWJZNCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:02:07 -0400
Date: Thu, 26 Oct 2006 15:01:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux@horizon.com
cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2 and very unstable NTP
In-Reply-To: <20061026123051.3831.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0610261449500.6761@scrub.home>
References: <20061026123051.3831.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Oct 2006, linux@horizon.com wrote:

> > Did you ask the author? It would really help to have more specific 
> > information here, e.g. what kernel interfaces are actually used in this 
> > configuration.
> 
> Er... I thought I *was* asking the authors of the Linux kernel/time*
> code.
> 
> If you're deeply suspiscious of a simple device driver, with publicly
> available code, that adds timestamping to the handling of DCD changed
> events from the serial ports, and exports those timestamps to user space,
> I can remove it.  The Acutime 2000 can timestamp pulses sent to it
> (via the RTS line), so I can get sub-microsecond time measurements anyway.

I don't have this hardware, so I can only guess and the less information I 
get the broader I have to guess. Sorry, but currently I don't have the 
time to go on such a broad hunt. Someone familiar with this code should a 
far easier time localizing the problem. It's not just kernel driver, there 
is also lot of code in user space which converts the data to time 
adjustments. There is also more than one way to adjust time, so I need 
more specific information about what is happening and what is expected to 
happen.

bye, Roman
