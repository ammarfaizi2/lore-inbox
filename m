Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUJIUan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUJIUan (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUJIU2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:28:04 -0400
Received: from mail.joq.us ([67.65.12.105]:19098 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S267374AbUJIU1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:27:48 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <1097269108.1442.53.camel@krustophenia.net>
	<20041008144539.K2357@build.pdx.osdl.net>
	<1097272140.1442.75.camel@krustophenia.net>
	<20041008145252.M2357@build.pdx.osdl.net>
	<1097273105.1442.78.camel@krustophenia.net>
	<20041008151911.Q2357@build.pdx.osdl.net>
	<20041008152430.R2357@build.pdx.osdl.net>
	<87zn2wbt7c.fsf@sulphur.joq.us>
	<20041008221635.V2357@build.pdx.osdl.net>
	<87is9jc1eb.fsf@sulphur.joq.us>
	<20041009121141.X2357@build.pdx.osdl.net>
From: "Jack O'Quin" <joq@io.com>
Date: 09 Oct 2004 15:27:24 -0500
In-Reply-To: <20041009121141.X2357@build.pdx.osdl.net>
Message-ID: <878yafbpsj.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Jack O'Quin (joq@io.com) wrote:
> > This adds a test against current->egid in addition to the explicit
> > check of current->gid.  I don't see any problem with that.  AFAICT,
> > the current->gid check is still useful.

Chris Wright <chrisw@osdl.org> writes:
> The egid makes a setgid-audio program be meaningful as well.

That works already, because we test the e_gid from the bprm structure,
right?  Is that redundant?
-- 
  joq
