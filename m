Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752396AbWCFSjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbWCFSjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbWCFSjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:39:12 -0500
Received: from cernmx04.cern.ch ([137.138.166.167]:3995 "EHLO cernmxlb.cern.ch")
	by vger.kernel.org with ESMTP id S1751973AbWCFSjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:39:11 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=WntUuLflNjmTGYV1Q03xxHrSUiJCpvVH/AlWAspXOHBFwAkAhWmnp2Vp+mnJ6EX16p5xmq8/tSm51VuwbpYf69yRBNOTKBSlHhGLKc2bnN5rN+8YoDD19vycRDxtLkWd;
Keywords: CERN SpamKiller Note: -52 Charset: west-latin
X-Filter: CERNMX04 CERN MX v2.0 051012.1312 Release
Message-ID: <440C81D7.9070608@cern.ch>
Date: Mon, 06 Mar 2006 19:39:19 +0100
From: Jiri Tyr <jiri.tyr@cern.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060128)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Sands <duncan.sands@math.u-psud.fr>
CC: linux-kernel@vger.kernel.org, mchehab@brturbo.com.br,
       video4linux-list@redhat.com, Michel Bardiaux <mbardiaux@mediaxim.be>
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
References: <440C5672.7000009@cern.ch> <200603061656.18846.duncan.sands@math.u-psud.fr>
In-Reply-To: <200603061656.18846.duncan.sands@math.u-psud.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2006 18:39:08.0902 (UTC) FILETIME=[41369060:01C6414D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michel Bardiaux wrote:
 > I was never able to make 4 bttv work together. There is every
 > probability of interrupt conflicts (but you didnt post proc/interrupts
 > and its hard reading lspci), and I seriously doubt the bus would let one
 > grab 4 sources full-size full-rate without losing frames and interrupts
 > here and there.

Here is my /proc/interrupts:

     CPU0
 0:  9332  IO-APIC-edge timer
 1:   144  IO-APIC-edge i8042
 2:     0        XT-PIC cascade
12:    93  IO-APIC-edge i8042
18:  9332 IO-APIC-level bttv2
19:  9332 IO-APIC-level libata, bttv3
21:  9332 IO-APIC-level bttv0
22:  9332 IO-APIC-level bttv1
NMI:    0
LOC: 9294
ERR:    0
MIS:    0

I have removed all unnecessary things from kernel. Libata I need for
SATA disk. Do you think that is some possibility how to make this four
bttv tuners working?

Jiri

