Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbUBNRnL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 12:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbUBNRnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 12:43:11 -0500
Received: from mx.laposte.net ([81.255.54.11]:18841 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S263491AbUBNRmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 12:42:50 -0500
Message-ID: <402E5F31.2010604@laPoste.net>
Date: Sat, 14 Feb 2004 18:47:29 +0100
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Organization: Adresse personnelle
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: fr-fr, fr, en-gb, en-us, en, ru
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: chris.siebenmann@utoronto.ca, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <402E3066.1020802@laPoste.net> <20040214154055.GH8858@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040214154055.GH8858@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sat, Feb 14, 2004 at 03:27:50PM +0100, Nicolas Mailhot wrote:
> 
>>There is no more justification to keep encoding undefined as there is to 
>>keep time zone undefined. Last I've seen we're all pretty happy system 
>>time actually means something on unix (unlike other systems where it can 
>>be anything depending on the location where the initial installation was 
>>performed).
> 
> 
> "System time" is amount of time elapsed since the epoch.  Period.  What does
> it have to any timezone?

And everyone agrees on the epoch and that's why it works.

(just like sensors output is not just any numerical value but has a 
well-defined unit)

With filenames we have a value but what it means exactly is a matter of 
conjecture. That's the problem.
(it wouldn't be if filenames were just magic cookies that never needed 
to be interpreted but there's a lot of actors, be it apps or humans that 
need to agree on what the byte string)

Cheers,

-- 
Nicolas Mailhot


