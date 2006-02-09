Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422757AbWBIB0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbWBIB0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 20:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422758AbWBIB0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 20:26:18 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:61625 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1422757AbWBIB0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 20:26:18 -0500
Message-ID: <43EA9A39.4040505@tlinx.org>
Date: Wed, 08 Feb 2006 17:26:17 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Commit validation/assurance; change control...
References: <43E935BA.8050605@tlinx.org> <43E943FD.7090508@tlinx.org> <20060208193202.GA8275@agluck-lia64.sc.intel.com> <43EA7680.6000207@tlinx.org> <Pine.LNX.4.58.0602081457500.1564@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0602081457500.1564@shark.he.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Linda, did you have some other point that you are trying to get to,
> or is that it?  There are real efforts being made, although not
> perfect.  That happens when people are involved.
>   
It depends on what tools you use to verify input.  How many
commits don't "compile"?  There are people involved in
that effort, but that doesn't mean we accept C-syntax
errors as being inevitable does it?

If something doesn't compile, isn't it expected that the author
will fix it before it becomes part of the mainline code?

Commit meta-information can as easily be verified for basic
"syntax" (field presence).  If a commit is missing basic
information, it could be bounced back to the submitter to be
fixed before being accepted into the mainline tree.

No more perfection is required than is already accepted for C-source
files: if they don't compile, fix them.  There's no discussions
about people making an "effort" to have kernel releases that compile.
They either do, or don't (ignoring vagaries of untested platform,
Config options or compiler differences).

> Anyway, it feels like you are just getting to the surface/edge
> of your complaint.
>   
Complaint is a bit stronger than I meant.  You could take it
as a report of a new "commit" that doesn't compile correctly.  That's
not usually a complaint in a development environment -- that's
part of the development, test and fix cycle.

I'm just trying to, programatically, read in the Changes file so
I can, perhaps, sort them by by some criteria.  I ran into "syntax"
errors in the Change-log regarding missing fields.  This is a an
_inquiry_ into what meta-information "should" be included with a commit:
What is expected?  What is required?  What is desired?

I'm not expecting the current version of the change log to be "fixed",
but if we have no measure or feedback regarding how well we are
adhering to *whatever* standard is "agreed" (or mandated), how can
we know if we are know if we are "there" yet?

Someday, maybe the 1-line descriptions could be complete enough for
automatic parsing & sorting so someone could look choose to look
at changes in a particular subsystem, driver or architecture.  But
that level of 'semantic' validity is a bit beyond simple
"commit" meta-info syntax checking. ;-)

Linda



