Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269217AbUI3APY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269217AbUI3APY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUI3APY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:15:24 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:47596 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S269217AbUI3APO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:15:14 -0400
Message-ID: <415B4FEE.2000209@mvista.com>
Date: Wed, 29 Sep 2004 17:14:38 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Christoph Lameter <clameter@sgi.com>, Ulrich Drepper <drepper@redhat.com>,
       johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: patches inline in mail
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com> <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com> <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com> <415AF4C3.1040808@mvista.com> <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com> <415B0C9E.5060000@mvista.com> <Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Unrelated to the CLOCK_PROCESS/THREAD_CPUTIME_ID discussion, just wanted 
> to comment on the 'patches inline vs attached' bit.
> 
> On Wed, 29 Sep 2004, George Anzinger wrote:
> 
> 
>>Christoph Lameter wrote:
>>
>>>On Wed, 29 Sep 2004, George Anzinger wrote:
>>>
>>>
>>>>Christoph Lameter wrote:
>>>>
>>>>Please, when sending patches, attach them.  This avoids problems with
>>>>mailers,
>>>>on both ends, messing with white space.  They still appear in line, at
>>>>least in
>>>>some mailers (mozilla in my case).
>>>
>>>
>>>The custom on lkml, for Linus and Andrew is to send them inline. I also
>>>prefer them inline. Will try to remember sending attachments when sending a
>>>patch to you.
>>
>>I think they WILL be inline as well as attached if you attach them.  The
>>difference is that in both presentations neither mailer will mess with white
>>space.  This means that long lines will not be wrapped and tabs vs space will
>>not be changed.
>>
> 
> Not all mailers show attachments inline. Mailers that do usually depend on 
> the mimetype of the attachment when choosing to show inline or not. pine 
> (my personal favorite) show attachments with a text/plain and similar 
> mime-type inline, but a not all mailers use that (I see a lot of attached 
> patches on lkml that don't show inline, and that's somewhat annoying).

So we should make sure that the mailer uses the right mime-type.  I suppose that 
depends on the mailer?
> 
> It's also harder to reply and comment on bits of a patch when your mailer 
> does not include attachments inline in a reply (even if it did show them 
> inline while reading the mail).
> Having to save the patch, open it in a text editor and then cut'n'paste 
> bits of it into the reply mail is a pain. Same goes for having to save & 
> open it in order to read it in the first place.

We agree.  Still, I have been bitten too many times by misshandled white space 
to trust pure inlineing.  Likewise on picking it up one would usually past it in 
the mail (I suppose) where as the attachment is through the mailer and less 
prone to missing a character.

The best answer, I think, is attachments that show as inline AND stay that way 
on the reply.

Guild lines on how to insure this are welcome.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

