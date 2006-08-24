Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWHXSjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWHXSjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWHXSjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:39:52 -0400
Received: from enyo.dsw2k3.info ([195.71.86.239]:29587 "EHLO enyo.dsw2k3.info")
	by vger.kernel.org with ESMTP id S1030423AbWHXSju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:39:50 -0400
Message-ID: <44EDF26B.7070404@citd.de>
Date: Thu, 24 Aug 2006 20:39:39 +0200
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Adrian Bunk <bunk@stusta.de>, David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
References: <32640.1156424442@warthog.cambridge.redhat.com> <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org> <20060824155814.GL19810@stusta.de> <Pine.LNX.4.61.0608241838430.16422@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608241838430.16422@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>On Thu, 2006-08-24 at 17:29 +0200, Adrian Bunk wrote:
>>>
>>>>        bool "Enable the block layer" depends on EMBEDDED 
>>>
>>>Please. no. CONFIG_EMBEDDED was a bad idea in the first place -- its
>>>sole purpose is to pander to Aunt Tillie.
>>
>>It's not for Aunt Tillie.
>>It's for an average system administrator who compiles his own kernel.
>>
>>CONFIG_BLOCK=n will only be for the "the kernel must become as fast as 
>>possible, and I really know what I'm doing" people.
> 
> 
> Then that should be CONFIG_I_AM_AN_EXPERT (CONFIG_EXPERT), not 
> CONFIG_EMBEDDED.

Or to quote the GUI-configuration of xine-ui

CONFIG_EXPERIENCE_LEVEL
With the options:
Beginner
Advanced
Expert
Master of the know universe

SCNR. ;-)





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

