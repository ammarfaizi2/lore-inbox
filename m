Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUH2PTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUH2PTT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUH2PTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:19:18 -0400
Received: from nysv.org ([213.157.66.145]:54207 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S268014AbUH2PTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:19:13 -0400
Date: Sun, 29 Aug 2004 18:17:29 +0300
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Spam <spam@tnonline.net>, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829151729.GC26192@nysv.org>
References: <1453776111.20040826131547@tnonline.net> <200408272358.i7RNweGh002703@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408272358.i7RNweGh002703@localhost.localdomain>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 07:58:40PM -0400, Horst von Brand wrote:
>
>So the _kernel_ has to know about thousands of formats, just in case it
>some blue day it comes across a strange file? Better leave that to the
>applications.

Or come up with a way to export some interface to userspace.

Or make a standard description format in something like XML that can be
used for arbitrary files and have userspace interface with that metadata
stream that is the XML.
This is, however, dangerously close to what we have now and does. not. work,
so the only added bonus we might have is the fact that it's endorsed by the
kernel.
I don't like this idea except as a last fallback solution...

>>   I  use  this  in  Windows  quite much.
>Then use it and be happy. No need to screw up Linux for that.

Linux does not need to be screwed up by that.
It can be done right.

>The descriptions might make sense to _you_, _now_. No guarantee they make
>any sense (or are in the least useful) for other users on your system, and

They also make perfect sense to me, and I would like this to have
had this yesterday. or last year ;)

>I might want them in arabic or some such. The descriptions might make no
>sense to you in a couple of years.

So what do you do if you use someone else's system and he doesn't have
Arabic man pages but you want them in Arabic?

And a description that doesn't make sense in many years is badly formed.

>>   Secondly, do you expect file managers like Nautilus and Konqueror to
>>   support  every piece of file format on the planet so they could read
>>   information directly from the documents?
>That's their (self-selected) job, yes.

Sure, but they store it differently in different places. Having them in
the actual file makes it universal.

I think the biggest issue is that you are arguing against this out of
some principle. There is a certain want for these new features among
the users, there are people who are willing to implement them, there
is Linus who seems to agree and accept.

What do you, and people who agree with you, lose if this gets implemented?
Drive space when you have the slightly-grown kernel sources downloaded?

-- 
mjt


