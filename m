Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUIUHtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUIUHtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 03:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUIUHtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 03:49:05 -0400
Received: from imap.gmx.net ([213.165.64.20]:899 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267511AbUIUHtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 03:49:00 -0400
X-Authenticated: #911537
Date: Tue, 21 Sep 2004 09:52:24 +0200
From: torbenh@gmx.de
To: "Jack O'Quin" <joq@io.com>
Cc: Jody McIntyre <lkml@modernduck.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20040921075224.GA4602@mobilat.informatik.uni-bremen.de>
References: <1094967978.1306.401.camel@krustophenia.net> <20040920202349.GI4273@conscoop.ottawa.on.ca> <87u0tslbuw.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0tslbuw.fsf@sulphur.joq.us>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 07:11:35PM -0500, Jack O'Quin wrote:
> Jody McIntyre <lkml@modernduck.com> writes:
> 
> > On Sun, Sep 12, 2004 at 01:46:18AM -0400, Lee Revell wrote:
> > 
> > > +	  Answer M to build realtime support as a Linux Security
> > > +	  Module.  Answering Y to build realtime capabilities into the
> > > +	  kernel makes no sense.
> > 
> > Why does this make no sense?
> 
> Before your /proc enhancement, it made no sense because there was no
> way to set parameters.  By default, the LSM does nothing.  We should
> change that comment now (as soon as it's working).

one can pass paremeters to the kernel on boot.
i think that the parameters get to the module somehow.
(the parameter stuff is handled by magic macros, which should now what
to do when not built as a module.
> 
> > I tried answering Y and it oopsed on boot.  I'll try and track down/fix
> > what is happening later.
> 
> Long ago, I built and ran it linked into the kernel (with different
> parameter defaults), which worked at the time.  It may matter how some
> of the other security modules are configured.  Perhaps some additional
> Kconfig dependency checking would help.  I'm not an expert at that.

i think jody will fix it.

> -- 
>   joq
> 

-- 
torben Hohn
http://galan.sourceforge.net -- The graphical Audio language
