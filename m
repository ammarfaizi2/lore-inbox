Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVCHF2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVCHF2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVCHF2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:28:41 -0500
Received: from mail.joq.us ([67.65.12.105]:22970 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261367AbVCHF2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:28:34 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, paul@linuxaudiosystems.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050112185258.GG2940@waste.org>
	<200501122116.j0CLGK3K022477@localhost.localdomain>
	<20050307195020.510a1ceb.akpm@osdl.org>
	<20050308043349.GG3120@waste.org>
	<20050307204044.23e34019.akpm@osdl.org>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 07 Mar 2005 23:30:57 -0600
In-Reply-To: <20050307204044.23e34019.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 7 Mar 2005 20:40:44 -0800")
Message-ID: <87acpesnzi.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Matt Mackall <mpm@selenic.com> wrote:
>>
>> I think Chris Wright's last rlimit patch is more sensible and ready to
>>  go.
>
> I must say that I like rlimits - very straightforward, although somewhat
> awkward to use from userspace due to shortsighted shell design.
>
> Does anyone have serious objections to this approach?

1. is likely to introduce multiuser system security holes like the one
created recently when the mlock() rlimits bug was fixed (DoS attacks)

2. requires updates to all the shells

3. forces Windows and Mac musicians to learn and understand PAM

4. is undocumented and has never been tested in any real music studios

-- 
  joq
