Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269127AbUINCiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269127AbUINCiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUINChu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:37:50 -0400
Received: from CPE-144-136-177-39.sa.bigpond.net.au ([144.136.177.39]:27930
	"EHLO modra.org") by vger.kernel.org with ESMTP id S269127AbUINCeW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:34:22 -0400
Date: Tue, 14 Sep 2004 12:04:17 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Ulrich Drepper <drepper@redhat.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: vDSO for ppc64 : Preliminary release #5
Message-ID: <20040914023416.GF21519@bubble.modra.org>
References: <1095051764.2664.267.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095051764.2664.267.camel@gaston>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 03:02:44PM +1000, Benjamin Herrenschmidt wrote:
> and a new version of the CFI informations for signal trampolines by
> Alan.

Which is busted.  I'm now generating .eh_frame directly, but you moved
.cfi_startproc/.cfi_endproc into V_FUNCTION_BEGIN/V_FUNCTION_END.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
