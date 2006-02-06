Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWBFKQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWBFKQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWBFKQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:16:34 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:34188 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1750836AbWBFKQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:16:34 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: gregkh@suse.de
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>
	<Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>
From: Jes Sorensen <jes@sgi.com>
Date: 06 Feb 2006 05:16:33 -0500
In-Reply-To: <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>
Message-ID: <yq04q3cokqm.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

[snip - excellent description of typedefs considered evil]

Linus> Maybe there are other cases too, but the rule should basically
Linus> be to NEVER EVER use a typedef unless you can clearly match one
Linus> of those rules.

Linus> In general, a pointer, or a struct that has elements that can
Linus> reasonably be directly accessed should _never_ be a typedef.

Hi,

This one sounds like yet another example of something any new Linux
developer should print and stick on his/her wall next to their
monitor.

A candidate for Documentation/ any volunteers?

Cheers,
Jes
