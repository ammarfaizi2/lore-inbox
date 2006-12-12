Return-Path: <linux-kernel-owner+w=401wt.eu-S932594AbWLMAXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWLMAXa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWLMAWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:22:53 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:41554 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932589AbWLMAWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:22:42 -0500
X-Greylist: delayed 1865 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 19:22:41 EST
Message-ID: <457F407B.4030602@citd.de>
Date: Wed, 13 Dec 2006 00:51:23 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaswinder Singh <jaswinderrajput@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Support 2.4 modules features in 2.6
References: <aa5953d60612120606g8c59542seaa440b7b0404ff5@mail.gmail.com>
In-Reply-To: <aa5953d60612120606g8c59542seaa440b7b0404ff5@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
> Hello,
> 
> I want to support old 2.4 modules features in 2.6 kernel modules:-
> 1. no kernel source tree is required to build modules.

I don't think that is possible.

There are a few "questions" that are quite fundamental when you want to
build a module that can be loaded by a given kernel.

About the most important fundamental "questions" i can think of ATM:
- UP/SMP
- Preempt yes/no
- RegParm yes/no
(x86)- High Memory off/4g/64G(IOW PAE yes/no)
And maybe a few more "not so fundamental" points.

AFAIK there is no way to build a module that would work in all of the
8/16 possible "kernel-types" you get with these 3/4 fundamental options
alone.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

