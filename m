Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUE1PTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUE1PTc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUE1PTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:19:31 -0400
Received: from colin2.muc.de ([193.149.48.15]:47877 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263448AbUE1PTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:19:30 -0400
Date: 28 May 2004 17:19:30 +0200
Date: Fri, 28 May 2004 17:19:30 +0200
From: Andi Kleen <ak@muc.de>
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
Message-ID: <20040528151930.GA39560@colin2.muc.de>
References: <20Oc4-HT-25@gated-at.bofh.it> <m3zn7su4lv.fsf@averell.firstfloor.org> <20040528125447.GB11265@redhat.com> <20040528132358.GA78847@colin2.muc.de> <20040528134600.GF7499@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528134600.GF7499@pazke>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My point stays that kernel interfaces should stay stable in the stable
> > series as far as possible (= unless terminally broken, but that's
> > clearly not the case here).  If you feel the need to clean up
> > something better wait for the unstable series.
> 
> I can't call dmi_scan.c a kernel interface, currently it's a crap.

Disagree. It works just fine in its current form, your patch doesn't
fix any bugs.

-Andi
