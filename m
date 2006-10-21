Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWJUEVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWJUEVk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 00:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWJUEVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 00:21:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:9569 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751215AbWJUEVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 00:21:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=DsVvRAdltmD2l4kza8ZPF9AXm+90ExtGV6balrZjulwOKqq8rsQXwYVdyo5JaQzt2xyHf+gpC26ZsGAx+vpxISpbXxGgBeHGf5so/UQRxrIUh2w6H/hsBr1O7+44CEnULY1vWa0cvqJKhPS2uMJoeV3mzJIG2RIr0gmlG1gUL4Q=
Date: Fri, 20 Oct 2006 21:22:44 -0700
From: Chris Largret <largret@gmail.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc1, timebomb?
Message-ID: <20061020212244.56f9f02b@localhost>
In-Reply-To: <200610200130.44820.gene.heskett@verizon.net>
References: <200610200130.44820.gene.heskett@verizon.net>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 01:30:44 -0400
Gene Heskett <gene.heskett@verizon.net> wrote:

> Greetings;
> 
> I just arrived home a few hours ago, and my wife said the outside lights 
> hadn't worked for the last 2 days.
> 
> I come in to check, the this machine, which runs some heyu scripts to do 
> this, was powered down.  So I powered it back up and it had to e2fsk 
> everything.  I have a ups with a fresh battery which passes the tests just 
> fine.
> 
> The only thing in the logs is a single line about eth0 being down:
> Oct 17 05:31:11 coyote kernel: eth0: link down.
> Oct 19 20:37:49 coyote syslogd 1.4.1: restart.
> 
> Uptime when this occurred was about 9 days.  Was this a known problem?

Out of curiosity, did you check the UPS logs? The low- (and mid- ?)
range ones I've played with have logs as well as the ability to tell
the computer when there is a power problem. I'd check those logs and
also look in the system BIOS for a way to power the computer back on
when power returns. If it was powered off, I don't believe it would be
kernel-related.

I could always be wrong, but from my own experiences kernel problems
result in a system that is on but not operational.

-- 
Chris Largret <http://www.largret.com>
