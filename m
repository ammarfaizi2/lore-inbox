Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbUJWSRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUJWSRv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 14:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUJWSRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 14:17:51 -0400
Received: from mail.joq.us ([67.65.12.105]:35201 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261275AbUJWSRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 14:17:36 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <1097272140.1442.75.camel@krustophenia.net>
	<20041008145252.M2357@build.pdx.osdl.net>
	<1097273105.1442.78.camel@krustophenia.net>
	<20041008151911.Q2357@build.pdx.osdl.net>
	<20041008152430.R2357@build.pdx.osdl.net>
	<87zn2wbt7c.fsf@sulphur.joq.us>
	<20041008221635.V2357@build.pdx.osdl.net>
	<87is9jc1eb.fsf@sulphur.joq.us>
	<20041009121141.X2357@build.pdx.osdl.net>
	<878yafbpsj.fsf@sulphur.joq.us>
	<20041009155339.Y2357@build.pdx.osdl.net>
	<874qkmtibt.fsf@sulphur.joq.us> <87zn2erzvx.fsf@sulphur.joq.us>
	<1098494878.4731.1.camel@krustophenia.net>
	<87is92rphb.fsf@sulphur.joq.us>
From: "Jack O'Quin" <joq@io.com>
Date: 23 Oct 2004 13:17:01 -0500
In-Reply-To: <87is92rphb.fsf@sulphur.joq.us>
Message-ID: <871xfp1eqq.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin <joq@io.com> writes:

> These minor corrections are included in the version appended below.
> I'll give it some testing tomorrow, let you know if I find a problem.

AFAICT it works with 2.6.9, but the realtime performance is terrible
(2.6.8.1 was much better).  The appropriate threads are running
SCHED_FIFO, but there are frequent xruns.  Could some change in the
kernel be affecting this?

I'm going to to try 2.6.9-mm1, to see if that works better.
-- 
  joq
