Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269151AbUINCwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269151AbUINCwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUINCtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:49:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:34954 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269157AbUINCr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:47:58 -0400
Subject: Re: vDSO for ppc64 : Preliminary release #5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Modra <amodra@bigpond.net.au>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Ulrich Drepper <drepper@redhat.com>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20040914023416.GF21519@bubble.modra.org>
References: <1095051764.2664.267.camel@gaston>
	 <20040914023416.GF21519@bubble.modra.org>
Content-Type: text/plain
Message-Id: <1095129823.2578.348.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 12:43:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 12:34, Alan Modra wrote:
> On Mon, Sep 13, 2004 at 03:02:44PM +1000, Benjamin Herrenschmidt wrote:
> > and a new version of the CFI informations for signal trampolines by
> > Alan.
> 
> Which is busted.  I'm now generating .eh_frame directly, but you moved
> .cfi_startproc/.cfi_endproc into V_FUNCTION_BEGIN/V_FUNCTION_END.

Oh, ok, yes, I need to remove those I suppose and add them back manually
to each individual function, right ?

Ben.


