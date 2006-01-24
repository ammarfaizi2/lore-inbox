Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWAXXdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWAXXdT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWAXXdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:33:19 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:5315 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750842AbWAXXdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:33:18 -0500
To: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] parport: add parallel port support for SGI O2
References: <87mzhqfq5y.fsf@groumpf.homeip.net>
	<20060122222425.6907656f.akpm@osdl.org>
	<87ek2ycy5q.fsf@groumpf.homeip.net>
From: Arnaud Giersch <arnaud.giersch@free.fr>
Date: Wed, 25 Jan 2006 00:33:16 +0100
In-Reply-To: <87ek2ycy5q.fsf@groumpf.homeip.net> (Arnaud Giersch's message
 of "Tue, 24 Jan 2006 00:38:57 +0100")
Message-ID: <87hd7t5hhf.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mardi 24 janvier 2006, vers 00:38:57 (+0100), j'ai écrit:

> I will correct the style.

[...]

> I will add a comment to explain it in the code.

[...]

> I did not realized that.  I will try to correct the problem.

An updated version is available at
     http://arnaud.giersch.free.fr/parport_ip32/parport_ip32-0.6.patch.gz

Since all changes are non-functional ones, I did not want to flood the
lists again with the full patch.

Changes are:

  * Address comments from Andrew Morton <akpm_at_osdl.org>:
    - Style: avoid single line "if" and "case" statements.
    - Turn some printk() into pr_debug1(), so that they only exist
      in debugging mode.
    - Add a comment about "volatile".
    - Add a comment about readsb() and writesb().
  * Only define DEBUG_PARPORT_IP32 if it is not already defined.
  * Remove the CVS $Id$ line.

        Arnaud
