Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVAGT5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVAGT5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVAGT42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:56:28 -0500
Received: from mail.joq.us ([67.65.12.105]:48838 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261548AbVAGTzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:55:09 -0500
To: Martin Mares <mj@ucw.cz>
Cc: Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050107162902.GA7097@ucw.cz>
	<200501071636.j07Gateu018841@localhost.localdomain>
	<20050107170603.GB7672@ucw.cz>
	<20050107092918.B2357@build.pdx.osdl.net>
	<20050107173229.GA9794@ucw.cz>
From: "Jack O'Quin" <joq@io.com>
Date: Fri, 07 Jan 2005 13:55:33 -0600
In-Reply-To: <20050107173229.GA9794@ucw.cz> (Martin Mares's message of "Fri,
 7 Jan 2005 18:32:29 +0100")
Message-ID: <87y8f5580a.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> writes:

>> Yes, SETPCAP became a gaping security hole.  Recall the sendmail hole.
>
> Hmmm, I don't remember now, could you give me some pointer, please?

I already did that...

> Jack O'Quin wrote:
> > The biggest problem was CAP_SETPCAP, which for good reasons[1] is
> > disabled in distributed kernels.  This forced every user to patch and
> > build a custom kernel.  Worse, it opened all our systems up to the
> > problems reported by this sendmail security advisory.

 [1] http://www.securiteam.com/unixfocus/5KQ040A1RI.html

-- 
  joq
