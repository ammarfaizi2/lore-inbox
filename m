Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269751AbUJWB2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269751AbUJWB2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269558AbUJWB1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:27:33 -0400
Received: from mail.joq.us ([67.65.12.105]:19179 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S269333AbUJWBXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:23:46 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
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
	<874qkmtibt.fsf@sulphur.joq.us>
From: "Jack O'Quin" <joq@io.com>
Date: 22 Oct 2004 20:23:30 -0500
In-Reply-To: <874qkmtibt.fsf@sulphur.joq.us>
Message-ID: <87zn2erzvx.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Chris Wright <chrisw@osdl.org> writes:
> 
> > - less generic variable names
> >   - s/any/rt_any/
> >   - s/gid/rt_gid/
> >   - s/mlock/rt_mlock/

Jack O'Quin <joq@io.com> writes:
> Is there a compelling reason for changing all the parameter names?
> 
> I would prefer not to do that.  It is incompatible for our current
> user base, and really does not seem like an improvement.  Those names
> only appear in the context of `realtime', so the `rt_' is completely
> redundant.

Studying his code, I see that I misunderstood what Chris had done.  

Only the internal static variable names changed.  There is no change
to the user interface.  

I have no objection at all to that, it's a good idea.
-- 
  joq
