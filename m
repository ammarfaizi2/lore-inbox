Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWGaTfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWGaTfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWGaTfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:35:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:43688 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932155AbWGaTfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:35:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=OAcF9mCyhawQ4iesxbD71ULEPOJMvWVPH5Dhfv6H5vzbLtFPDlTLCPjqDhaMVIuJaP0nqbXPcNwpujvVk0XW0eojCH2cPgMmtyiIZNmqhxLEIdGpJgo4fN+n5F6RmkqjYU9yio9Dk4eyTgwgyaXhBu3d9eRcl87rL4hmDLexvWI=
Date: Mon, 31 Jul 2006 12:34:54 -0700
From: Clay Barnes <clay.barnes@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
Message-ID: <20060731193454.GF17206@HAL_5000D.tc.ph.cox.net>
References: <20060731125846.aafa9c7c.reiser4@blinkenlights.ch>
	<20060731144736.GA1389@merlin.emma.line.org>
	<20060731175958.1626513b.reiser4@blinkenlights.ch>
	<20060731162224.GJ31121@lug-owl.de>
	<Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>
	<20060731173239.GO31121@lug-owl.de>
	<20060731181120.GA9667@merlin.emma.line.org>
	<20060731184314.GQ31121@lug-owl.de>
	<20060731191712.GE17206@HAL_5000D.tc.ph.cox.net>
	<1154374923.7230.99.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154374923.7230.99.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:42 Mon 31 Jul     , Alan Cox wrote:
> Ar Llu, 2006-07-31 am 12:17 -0700, ysgrifennodd Clay Barnes:
> > Of course, if ext3 were proven to be more robust against failures, I bet
> > the reiser team would be very interested in all the forensic data you
> > can offer, since, from what I've seen, they are always trying to make
> > reiser as good as possible---in speed, flexability, *and* robustness.
> 
> Its well accepted that reiserfs3 has some robustness problems in the
> face of physical media errors. The structure of the file system and the
> tree basis make it very hard to avoid such problems. XFS appears to have
> managed to achieve both robustness and better data structures. 

Yes, that is true, and I think that's a big motivator for the reiser
team to get reiser4 in a place where people can't say that.  I suspect
that they know that reiserfs's shortcomings in that respect are probably
the biggest deterrent to using that fs, and they'll do everything they
can to prevent such a problem in reiser4.  That's pure conjecture based
on the stuff I see on the list, so if I'm wrong, reiser people, please
correct me.

--Clay

> 
> How reiser4 compares I've no idea. 
> 
> Alan
