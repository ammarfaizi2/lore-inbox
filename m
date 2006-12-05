Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937428AbWLEH1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937428AbWLEH1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 02:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937467AbWLEH1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 02:27:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:11495 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937428AbWLEH1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 02:27:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=i7EOGIA4e/Ny7D8z4jROOwRIaimwxIF1qZq8w5AvG21Wocc+58SjtdrKFVqTOAHchnKCBqf3FHZ1yQ/bqFVkNChKDvNJHA+EN0y/hyL/+kY5KwlbdOFj9qS9ntOUbp1bvDJmWRnHdQFd6txcGtWYv4s6hoauzJrc2Nt+SdOOErs=
Message-ID: <45751F19.9010208@gmail.com>
Date: Tue, 05 Dec 2006 08:26:17 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Aucoin@Houston.RR.com, "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: la la la la ... swappiness
References: <200612050641.kB56f7wY018196@ms-smtp-06.texas.rr.com> <45751955.8010506@yahoo.com.au>
In-Reply-To: <45751955.8010506@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Aucoin wrote:

>> Ummm, shm_open, ftruncate, mmap ? Is it a trick question ? The process
>> responsible for initially setting up the shared area doesn't stay 
>> resident.
> 
> The issue is that the shm pages should show up in the active and
> inactive lists. But they aren't, and you seem to have about 1542524K
> unacconted for. Weird.
> 
> Can you try getting the output of /proc/vmstat as well?

Haven't followed along on this thread, but couldn't help notice the 
ftruncate there and some similarity to a problem I once experienced 
myself. Is ext3 involved? If so, maybe:

http://mail.nl.linux.org/linux-mm/2002-11/msg00110.html

is still or again being annoying?

Rene.

