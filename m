Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVF1VwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVF1VwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVF1Vuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:50:52 -0400
Received: from alpha.polcom.net ([217.79.151.115]:16862 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261301AbVF1VsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:48:11 -0400
Date: Tue, 28 Jun 2005 23:48:05 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>
Subject: Re: [patch] latest inotify.
In-Reply-To: <1119994746.6745.28.camel@betsy>
Message-ID: <Pine.LNX.4.63.0506282343320.7125@alpha.polcom.net>
References: <1119989024.6745.20.camel@betsy>  <Pine.LNX.4.63.0506282322000.7125@alpha.polcom.net>
 <1119994746.6745.28.camel@betsy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Robert Love wrote:

> On Tue, 2005-06-28 at 23:31 +0200, Grzegorz Kulewski wrote:
>
>> 0aa3dfb1940a12a4245ec87b4246db85b55abe40  inotify-0.23-rml-2.6.12-rc4-8.patch
>
> Oh, I just noticed this.
>
> Can you please try with this latest release
> (inotify-0.23-rml-2.6.12-14.patch)?
>
> There is some code that might fix this for you, or reveal further what
> is going on.

I will try that as fast as I can. I am not using -mm's since 2.6.2-mm2 
because they are usually too broken for me :-(.

IIRC, similar bug was discussed on #gentoo-bugs recently and is probably 
somewhere in Gentoo Bugzilla (http://bugs.gentoo.org). Several people 
noticed this. So probably if you can mount and use NTFS for a while and 
then umount it without problems this is probably fixed. If not - you can 
reproduce it simply (it is 100% reproductible and occurs only on inotified 
kernels).


Thanks,

Grzegorz Kulewski
