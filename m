Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTH1SuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264214AbTH1SuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:50:12 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:63365 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S264188AbTH1Ss1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:48:27 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and hardware reports a non fatal incident
Date: Thu, 28 Aug 2003 18:28:12 +0100
User-Agent: KMail/1.5.3
References: <200308281548.44803.tomasz_czaus@go2.pl> <20030828084640.68fe827d.rddunlap@osdl.org>
In-Reply-To: <20030828084640.68fe827d.rddunlap@osdl.org>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308281828.12833.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 Aug 2003 16:46, Randy.Dunlap wrote:
> On Thu, 28 Aug 2003 15:48:44 +0200 Tomasz Czaus <tomasz_czaus@go2.pl> 
wrote:
> | Hello,
> |
> | when my system is booting I can see such a message:
> |
> | kernel: MCE: The hardware reports a non fatal, correctable incident
> | occurred on CPU 0.
> | kernel: Bank 0: e664000000000185

Yeah, I get one of those on boot, too.  Or at least I did.  I was going to 
turn the processor checking stuff back on to see if it happened 
consistently.  What processor is it, Tomasz?  Mine's an Athlon.  Output of 
"cat /proc/cpuinfo" at the end, if anyone's remotely interested...

> Use "parsemce" from here:
>   http://www.codemonkey.org.uk/projects/parsemce/
> to decode it.
>
> So 2.6 has more/better/different processor error checking.

Thanks for the link, Randy, I'll give it a go tonight.  Although with my 
knowledge of current processor archictecture, I'm guessing it'll parse it 
from one format I don't have a clue about into a more verbose format I don't 
have a clue about ;-)

Cheers,

M

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1195.130
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2367.48


-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
