Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVANOJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVANOJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVANOJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:09:04 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:39176 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261989AbVANOIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:08:50 -0500
To: Ulrich Drepper <drepper@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
References: <20050113134620.GA14127@boetes.org>
	<a36005b5050113131179d932eb@mail.gmail.com>
	<20050113225244.GH14127@boetes.org>
	<a36005b505011323061bd2e4a9@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: more boundary conditions than the Middle East.
Date: Fri, 14 Jan 2005 14:08:42 +0000
In-Reply-To: <a36005b505011323061bd2e4a9@mail.gmail.com> (Ulrich Drepper's
 message of "14 Jan 2005 07:09:29 -0000")
Message-ID: <87652014t1.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jan 2005, Ulrich Drepper yowled:
> Finally, the gcc patch is not going to work as is on architectures
> like IA-64 which do not have the kind of adressing modes which are
> needed for the code to work.

Nor does it work on SPARC-like processors (it tries, but the resulting
programs dump core).

> To fully understand the problem, you need to understand compiler
> design, and especially RTL.  The latter by itself is another problem:
> getting the code work in gcc 4 is at least challenging due the SSA.

Probably a rewrite (using trees instead of RTL) would be easier;
preferably by someone who actually documents what the patch is doing and
submits it in a fashion acceptable to the GCC people; i.e. not in a
single huge nearly-unexplained lump followed by all queries going
unanswered.

Working directly on trees would have the advantage that it would work on
every platform GCC supports straight away (or at least it would have a
higher chance of doing so).

-- 
`Blish is clearly in love with language. Unfortunately,
 language dislikes him intensely.' --- Russ Allbery
