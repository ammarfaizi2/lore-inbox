Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSKRQFL>; Mon, 18 Nov 2002 11:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSKRQFK>; Mon, 18 Nov 2002 11:05:10 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:19423 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262821AbSKRQFJ>;
	Mon, 18 Nov 2002 11:05:09 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF3806E8F4.0F4B2B9B-ON85256C75.005894C5@pok.ibm.com>
From: "Khoa Huynh" <khoa@us.ibm.com>
Date: Mon, 18 Nov 2002 10:11:55 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 11/18/2002 11:11:58 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arnaldo Carvalho de Melo wrote:
>> >One thing we've done before in other bug-tracking systems was to create
>> >a "STALE" state (or something similar) for this type of bug. So it
>> >wouldn't get closed (I have seen this done as a closing resolution, but
>> >I think that's a bad idea), but it wouldn't be in the default searches
>> >either ... you could just select it if you wanted it ... does that
sound
>> >sane? (obviously we don't need this yet, but might be a good plan
>> >longer-term).
>
>> Personally...  if they really are bugs, I would rather keep them open,
>> even in the absence of a maintainer...   maybe that's not scalable, but
>> I would rather not auto-expire things which really are bugs.  The
>> maintainer (or "someone who cares") may not appear until the next stable

>> series, for example.  Vendors do that alot.
>
>Jeff, ok, so we could do as vendors: mark the ticket as LATER, or whatever
>that doesnt make clearly stale tickets that nobody is looking appear on
>the default queries.
>
>If somebody is _so_ interested in a particular feature he/she can look for
>tickets marked LATER, add comments and state that he/she is working on it,
>provide more info, etc.

Currently the kernel bugzilla has a state called DEFERRED (with resolution
WILL_FIX_LATER) for this type of inactive bugs.  Anyone who is interested
in these bugs can set the query to look at them; otherwise, they are not
on the active bug list.  They are not closed either -- they are just
"deferred".




