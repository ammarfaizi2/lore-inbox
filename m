Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268452AbTGOQzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269017AbTGOQzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:55:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:11617 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S268452AbTGOQy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:54:56 -0400
Date: Tue, 15 Jul 2003 18:11:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: ACPI-Devel mailing list <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ACPI patches updated (20030714)
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EE8E@orsmsx401.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0307151805020.7780-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003, Grover, Andrew wrote:
> 
> Make it so acpismp=force works (reported by Andrew Morton)

But we don't want "acpismp=force" to work, it now serves no purpose
but to confuse.  May I push again to Marcelo my patch you acked
before, which removes it completely?  I had been waiting to say it's
in 2.6, but Andrew didn't push it from 2.5-mm into 2.6 - any reason?

Whereas we would still like "noht" to work, but it's now beyond me.

Hugh

