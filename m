Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTDHOBp (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 10:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTDHOBo (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 10:01:44 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:272 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id S261464AbTDHOBn (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 10:01:43 -0400
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Cc: linux-kernel@vger.kernel.org, mru@users.sourceforge.net
Subject: Re: Emulating insns on Alpha
References: <871y0doe68.fsf@student.uni-tuebingen.de>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 08 Apr 2003 16:13:04 +0200
In-Reply-To: Falk Hueffner's message of "08 Apr 2003 05:34:23 +0200"
Message-ID: <yw1xistpqdqn.fsf@manganonaujakasit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Falk Hueffner <falk.hueffner@student.uni-tuebingen.de> writes:

> > Are there any patches around that emulate the BWX instruction set on
> > older Alpha CPUs, or should I write it myself?
> 
> There's an ancient one at
> http://www.alphalinux.org/archives/axp-list/October1999/0500.html,
> although it's probably easier to write it from scratch. I'd write the
> whole thing in C, the trap is already so expensive that it's of no use
> trying to be clever when emulating the particular instructions (except
> when you replace the instruction with a jump to a stub, which seems
> somewhat hairy, but feasible).

If you think that's hairy, take a look at this:
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/tc2/tc2/include/Attic/tc2_autoload.h?rev=1.1.2.5&only_with_tag=dev-0_4&content-type=text/vnd.viewcvs-markup

-- 
Måns Rullgård
mru@users.sf.net
