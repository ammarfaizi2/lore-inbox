Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUIUALz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUIUALz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 20:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUIUALy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 20:11:54 -0400
Received: from mail.joq.us ([67.65.12.105]:65451 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S267410AbUIUALx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 20:11:53 -0400
To: Jody McIntyre <lkml@modernduck.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <1094967978.1306.401.camel@krustophenia.net>
	<20040920202349.GI4273@conscoop.ottawa.on.ca>
From: "Jack O'Quin" <joq@io.com>
Date: 20 Sep 2004 19:11:35 -0500
In-Reply-To: <20040920202349.GI4273@conscoop.ottawa.on.ca>
Message-ID: <87u0tslbuw.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre <lkml@modernduck.com> writes:

> On Sun, Sep 12, 2004 at 01:46:18AM -0400, Lee Revell wrote:
> 
> > +	  Answer M to build realtime support as a Linux Security
> > +	  Module.  Answering Y to build realtime capabilities into the
> > +	  kernel makes no sense.
> 
> Why does this make no sense?

Before your /proc enhancement, it made no sense because there was no
way to set parameters.  By default, the LSM does nothing.  We should
change that comment now (as soon as it's working).

> I tried answering Y and it oopsed on boot.  I'll try and track down/fix
> what is happening later.

Long ago, I built and ran it linked into the kernel (with different
parameter defaults), which worked at the time.  It may matter how some
of the other security modules are configured.  Perhaps some additional
Kconfig dependency checking would help.  I'm not an expert at that.
-- 
  joq
