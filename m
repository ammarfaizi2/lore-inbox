Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVAEEDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVAEEDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 23:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVAEEDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 23:03:47 -0500
Received: from mail.joq.us ([67.65.12.105]:1705 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262239AbVAEEDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 23:03:46 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1104374603.9732.32.camel@krustophenia.net>
	<20050103140359.GA19976@infradead.org>
	<1104862614.8255.1.camel@krustophenia.net>
	<20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us>
	<1104865198.8346.8.camel@krustophenia.net>
	<1104878646.17166.63.camel@localhost.localdomain>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 04 Jan 2005 22:04:33 -0600
In-Reply-To: <1104878646.17166.63.camel@localhost.localdomain> (Alan Cox's
 message of "Wed, 05 Jan 2005 00:01:55 +0000")
Message-ID: <87acroikry.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Maw, 2005-01-04 at 18:59, Lee Revell wrote:
>> We could do it the was OSX (our real competition) does if that would
>> make people happy.  They just let any user run RT tasks.  Oh wait, but
>> that's a "broken design", everyone knows that OSX is a joke, no one
>> would use *that* OS to mix a CD or score a movie.  :-)
>
> You can do that already, just make everyone root

Surely you're joking.  Is this actually a serious proposal?

> The problem with uid/gid based hacks is that they get really ugly to
> administer really fast. Especially once you have users who need realtime
> and hugetlb, and users who need one only.

This is why POSIX requires supplementary groups.

All I had to do on my system was...

  # adduser joq audio

That is considerably easier than hacking rlimits values via PAM.
-- 
  joq
