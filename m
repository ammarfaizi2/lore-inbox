Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269732AbRHMBqP>; Sun, 12 Aug 2001 21:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269706AbRHMBqF>; Sun, 12 Aug 2001 21:46:05 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:13440 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S269687AbRHMBpw>; Sun, 12 Aug 2001 21:45:52 -0400
Message-ID: <3B77302C.96C79272@randomlogic.com>
Date: Sun, 12 Aug 2001 18:41:00 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: S2464 (K7 Thunder) hangs -- some lessons learned
In-Reply-To: <20010812212430.A9300@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Small note. The K7 Thunder is S2462, unless there is another, possibly
newer, version released?)

"Eric S. Raymond" wrote:
> 

[SNIP]
> 
> OK, so the lessons here are:
> 
> 1. The S2464 needs to be configured with "Use PCI Interrupt Entries In MP
>    Table" for sanity to prevail, and

I have been running my K7 in this mode since purchase. Could this be why
I see no SB Live!/ EMU10K problems (though I am running 2.4.7 kernels
now)?

> 
> 2. When you see a box hang that's clearly related to a daughtercard, *run*
>    (do not walk) to your local /proc directory, cat /proc/pci and check out
>    the IRQ assignments.

Problem is, when it does hang, I can't get there as the system is
completely locked, including ssh and telnet.

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
