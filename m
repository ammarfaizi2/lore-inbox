Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVLPMXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVLPMXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVLPMXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:23:21 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:60611 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932224AbVLPMXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:23:20 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: 7eggert@gmx.de
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 14:22:39 +0200
User-Agent: KMail/1.8.2
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Alex Davis <alex14641@yahoo.com>
References: <5kh6K-7KC-3@gated-at.bofh.it> <5kiFR-1mi-11@gated-at.bofh.it> <E1EnDOo-0006Gd-Na@be1.lrz>
In-Reply-To: <E1EnDOo-0006Gd-Na@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161422.39473.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 December 2005 13:05, Bodo Eggert wrote:
> Kyle Moffett <mrmacman_g4@mac.com> wrote:
> 
> > Enough already!  These concerns have been raised already, and found
> > to be insufficient.  There are several points:
> > 
> > 1)    ndiswrapper is broken already, and works sheerly by luck anyways;
> > NT stacks are 12kb, so you're already asking for stack overflows by
> > using it.
> > 2)    ndiswrapper encourages use of binary drivers instead of the open-
> > source ones that need the testers, so you're only hurting yourselves
> > in the long run.
> 
> ACK. So where is the driver for the Netgear WG511 Softmac card I'm supposed
> to test? I bought this card because it was labled as being supported, and it
> turned out that it wasn't, and just nobody cared to update the list of
> supported cards with the warning about the unsupported variant.

We do need more people working on wireless front.
OTOH, more people bitching about bad situation on wireless front
doesn't make it any better.
--
vda
