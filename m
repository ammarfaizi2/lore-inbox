Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269668AbUJSScJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269668AbUJSScJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269662AbUJSS1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:27:42 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:1711 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S269584AbUJSSQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:16:17 -0400
Message-ID: <417550FB.8020404@drdos.com>
Date: Tue, 19 Oct 2004 11:38:03 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>Ok,
> despite some naming confusion (expanation: I'm a retard), I did end up
>doing the 2.6.9 release today. And it wasn't the same as the "-final" test
>release (see explanation above).
>
>Excuses aside, not a lot of changes since -rc4 (which was the last
>announced test-kernel), mainly some UML updates that don't affect anybody
>else. And a number of one-liners or compiler fixes. Full list appended.
>
>		Linus
>  
>
The memory sickness with disappearing buffers, and the BIO callback 
problems with the
SCSI layer previously reported appear to be corrected. This release is 
very solid and
withstands 400 MB/S I/O to disk from 3GB/1GB split kernel/user memory 
configurations
and does not have the disappearing memory problems I was experiencing 
with massive
BIO/skb I/O loading. The memory pressure being exerted is constant and 
the kernel
holds steady and stable enough for us to use and ship in our products 
based on our
testing of the 2.6.9 release over two days.

On a side note, the GPL buyout previously offered has been modified. We 
will be contacting
individual contributors and negotiating with each copyright holder for 
the code we wish to
convert on a case by case basis. The remaining portions of code will 
remain GPL
The 50K per copy offer still stands for the whole thing if you guys can 
ever figure out
how to set something like this up.
:-)

Although we do not work with them and are in fact on the the other side 
of Unixware from a
competing viewpoint, SCO has contacted us and identifed with precise 
detail and factual
documentation the code and intellectual property in Linux they claim was 
taken from Unix.
We have reviewed their claims and they appear to create enough 
uncertianty to warrant
removal of the infringing portions.

We have identified and removed the infringing portions of Linux for our 
products that
SCO claims was stolen from Unix. They are:

JFS, XFS, All SMP support in Linux, and RCU.

They make claims of other portions of Linux which were taken, however, 
these other claims
do not appear to be supported with factual evidence.

Jeff

