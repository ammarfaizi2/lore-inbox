Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263265AbTECG42 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 02:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbTECG42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 02:56:28 -0400
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:60812 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S263265AbTECG41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 02:56:27 -0400
Date: Sat, 3 May 2003 08:08:48 +0100 (BST)
From: Matt Bernstein <mb--lkml@dcs.qmul.ac.uk>
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@digeo.com>, elenstev@mesatop.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
In-Reply-To: <20030503025307.GB1541@averell>
Message-ID: <Pine.LNX.4.55.0305030800140.1304@jester.mews>
References: <20030502020149.1ec3e54f.akpm@digeo.com> <1051905879.2166.34.camel@spc9.esa.lanl.gov>
 <20030502133405.57207c48.akpm@digeo.com> <1051908541.2166.40.camel@spc9.esa.lanl.gov>
 <20030502140508.02d13449.akpm@digeo.com> <1051910420.2166.55.camel@spc9.esa.lanl.gov>
 <Pine.LNX.4.55.0305030014130.1304@jester.mews> <20030502164159.4434e5f1.akpm@digeo.com>
 <20030503025307.GB1541@averell>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (19Br8X-0006sz-EO)
X-Auth-User: jonquil.thebachchoir.org.uk
X-uvscan-result: clean (19Br8b-0002wJ-A3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:53 +0200 Andi Kleen wrote:
>> > 
>> > Bizarrely I have a nasty crash on modprobing e100 *without* kexec (having
>> > previously modprobed unix, af_packet and mii) and then trying to modprobe
>> > serio (which then deadlocks the machine).
>> > 
>> > 	http://www.dcs.qmul.ac.uk/~mb/oops/
>> 
>> Andi, it died in the middle of modprobe->apply_alternatives()
>
>The important part of the oops - the first lines are missing in the .png.
>
>What is the failing address? And can you send me your e100.o ?

I'm sorry I can't get to the machine now till Tuesday. I'll try to get it 
into a smaller font, or failing that a serial console if you like.

I've posted e100.{,k}o, vmlinux and System.map to the above URL. FWIW, 
they both give "c010e840 T apply_alternatives". I've also posted ".config" 
which Apache elects not to list :)

Does any of the above help?
