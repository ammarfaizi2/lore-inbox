Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269144AbUINDMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbUINDMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269079AbUINDM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:12:29 -0400
Received: from CPE-144-136-177-39.sa.bigpond.net.au ([144.136.177.39]:31514
	"EHLO modra.org") by vger.kernel.org with ESMTP id S269144AbUINDJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:09:50 -0400
Date: Tue, 14 Sep 2004 12:39:46 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Ulrich Drepper <drepper@redhat.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: vDSO for ppc64 : Preliminary release #5
Message-ID: <20040914030946.GH21519@bubble.modra.org>
References: <1095051764.2664.267.camel@gaston> <20040914023416.GF21519@bubble.modra.org> <1095129823.2578.348.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095129823.2578.348.camel@gaston>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 12:43:43PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2004-09-14 at 12:34, Alan Modra wrote:
> > On Mon, Sep 13, 2004 at 03:02:44PM +1000, Benjamin Herrenschmidt wrote:
> > > and a new version of the CFI informations for signal trampolines by
> > > Alan.
> > 
> > Which is busted.  I'm now generating .eh_frame directly, but you moved
> > .cfi_startproc/.cfi_endproc into V_FUNCTION_BEGIN/V_FUNCTION_END.
> 
> Oh, ok, yes, I need to remove those I suppose and add them back manually
> to each individual function, right ?

Yes please.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
