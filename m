Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVAaM7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVAaM7C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVAaM7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:59:02 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:15350 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261186AbVAaM6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:58:23 -0500
From: Peter Busser <busser@m-privacy.de>
Organization: m-privacy
To: linux-kernel@vger.kernel.org
Subject: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Date: Mon, 31 Jan 2005 13:57:59 +0100
User-Agent: KMail/1.7.1
References: <200501311015.20964.arjan@infradead.org>
In-Reply-To: <200501311015.20964.arjan@infradead.org>
Cc: Arjan van de Ven <arjan@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501311357.59630.busser@m-privacy.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm not entirely happy yet (it shows a bug in mmap randomisation) but
> it's way better than what you get in your tests (this is the
> desabotaged
> 0.9.6 version fwiw)

As you may or may not know, I am the author of PaXtest. Please tell me what a 
``desabotaged'' version of PaXtest exactly is. I've never seen a 
``sabotaged'' PaXtest and I'm interested in finding out who sabotaged it and 
for what purpose.

Come to think of it, sabotaging a test program seems to be a rather stupid 
concept. I mean, if you don't like the results, then don't run it. For me the 
integrity of PaXtest is very important. I mean, who would trust a test-suite 
if it produces manipulated results? Right, noone! Why would I want to write a 
test-suite noone uses? Right, I wouldn't, it is a waste of time! It is boring 
to write a test-suite. So it better not be a waste of time! I'm sincerely 
flattered by the fact that someone as famous as you uses PaXtest.

Well, PaXtest was designed to dig up hard facts about how well a system 
protects process integrity. So, if someone sabotages PaXtest and releases a 
changed version, that means that person clearly has the opposite intention, 
which is producing false information.

The whole concept of sabotaging PaXtest and rigging results doesn't make sense 
to me. People who do that must not be happy with the results and gain 
something by rigging them. But to think that it would go unnoticed...? First 
of all, if you don't like the results, don't run it! Second, run kiddie mode 
if you want to use PaXtest to feel warm and cozy. Third, the code is out 
there, anyone can download, compile, run and dissect it. Fourth, it is only a 
few lines of code per test. In other words, it is trivial to understand for 
anyone who is worth his salt. Therefore anyone who would want to sabotage it, 
can easily be publicly exposed and dealt with accordingly. Only stupid people 
would not be able to figure this out right away or be stupid enough to do it 
anyway. I honestly can't think of anyone that stupid... But then, you never 
know, I've been surprised before.

Anyways, I know there are some problems with PaXtest on Fedora, caused by 
PT_GNU_STACK stuff AFAIK. Unfortunately I don't have access to a Fedora 
machine and therefore am not able to fix and test it. But I would love to 
have PaXtest working on Fedora. So if you have it working on Fedora, feel 
free to send in a patch. There are probably more people who use Fedora who 
want to check their system's security, so you would really help those people.

I'm sorry to have to bother the people on this list, as you have much more 
important things to do. But for me personally, the integrity of PaXtest (and 
related to that, my personal integrity) matters a great deal. So I'd like to 
get to the bottom of this, even if that means bothering lkml. I hope Arjan 
can provide facts soon, so I can take action against this sabotage. If anyone 
else on this mailing list has information on this sabotaged PaXtest matter, 
then please speak up.

As a side note, I am really glad that this code goes into the kernel. It is 
good to finally see some security being added to the Linux kernel. Big thumbs 
up for the good work!

Groetjes,
Peter.
