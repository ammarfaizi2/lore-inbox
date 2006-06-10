Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbWFJSfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbWFJSfK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbWFJSfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:35:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:42142 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030475AbWFJSfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:35:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PYbzmqLT9q8/JBcHRSBW3m2jN087fFL2BovymxMxoXS6KE8uxuwXeegpl2bXRmnuQ6We3LlcUpN26MdvHiFE6otxrLC8iEZorKX4R/cSajLsguvSOo1lPKXrp4CV0FvqJOXyqUyrVr5Uj8+iJDabe3USvW/7z9sqNAIlSYQRDKI=
Message-ID: <6bffcb0e0606101135v6771110ft462f0dfdfcc45962@mail.gmail.com>
Date: Sat, 10 Jun 2006 20:35:05 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: 2.6.16-rc6-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606101118410.7535@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	 <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
	 <20060610092412.66dd109f.akpm@osdl.org>
	 <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com>
	 <20060610100318.8900f849.akpm@osdl.org>
	 <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com>
	 <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com>
	 <Pine.LNX.4.64.0606101118410.7535@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Sat, 10 Jun 2006, Michal Piotrowski wrote:
> > [michal@ltg01-fedora linux-mm]$ cat ~/page_alloc.patch | patch -p1 --dry-run
> > patching file mm/page_alloc.c
> > Hunk #1 FAILED at 1583.
> > Hunk #2 succeeded at 1604 (offset 1 line).
> > 1 out of 3 hunks FAILED -- saving rejects to file mm/page_alloc.c.rej
> > patching file include/linux/page-flags.h
> >
> > PITA for people that aren't kernel hackers.
>
> Sorry that patch was still against mm1. Here is a fixed up version that
> applies cleanly against mm2:
>

Great, thanks!

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
