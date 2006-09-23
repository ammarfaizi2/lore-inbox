Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWIWLic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWIWLic (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWIWLic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:38:32 -0400
Received: from mail.enyo.de ([212.9.189.167]:10249 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750739AbWIWLib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:38:31 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
Date: Sat, 23 Sep 2006 13:38:09 +0200
In-Reply-To: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> (James
	Bottomley's message of "Fri, 22 Sep 2006 11:15:50 -0500")
Message-ID: <87zmcqq0da.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Bottomley:

>     Further, the FSF's attempts at drafting and re-drafting these
> provisions have shown them to be a nasty minefield which keeps ensnaring
> innocent and beneficial uses of encryption and DRM technologies so, on such
> demonstrated pragmatic ground, these clauses are likewise dangerous and
> difficult to get right and should have no place in a well drafted update to
> GPLv2.

There is a very simple litmus test for DRM code: code that cannot be
altered or removed, according to applicable law or other agreements.
The GPLv3 could forbid the addition of such code to a covered code
base, I suppose.  However, this runs contrary to the DRM-like optional
clauses in the GPLv3 (mandatory access through sources over a
communication channel, certain forms of copyright notices).

I think several of these optional clauses are bad.  Even the copyright
notices can be annoying (although it's already in GPLv2).  For
instance, if I run

  emacs somefile.c

from the command line, somefile.c doesn't show up on in the editor,
but the copyright notice.  Of course, you can put 

  (defun display-splash-screen () (interactive))

in a startup file, but if you do this as a distributor, it might be a
GPLv2 violation.
