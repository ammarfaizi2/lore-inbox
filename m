Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263529AbUE1PYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUE1PYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUE1PYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:24:22 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:26597 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263324AbUE1PYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:24:21 -0400
Date: Fri, 28 May 2004 16:22:46 +0100
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
Message-ID: <20040528152246.GD11265@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@muc.de>,
	linux-kernel@vger.kernel.org
References: <20Oc4-HT-25@gated-at.bofh.it> <m3zn7su4lv.fsf@averell.firstfloor.org> <20040528125447.GB11265@redhat.com> <20040528132358.GA78847@colin2.muc.de> <20040528134600.GF7499@pazke> <20040528151930.GA39560@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528151930.GA39560@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 05:19:30PM +0200, Andi Kleen wrote:
 > > > My point stays that kernel interfaces should stay stable in the stable
 > > > series as far as possible (= unless terminally broken, but that's
 > > > clearly not the case here).  If you feel the need to clean up
 > > > something better wait for the unstable series.
 > > 
 > > I can't call dmi_scan.c a kernel interface, currently it's a crap.
 > 
 > Disagree. It works just fine in its current form, your patch doesn't
 > fix any bugs.

Actually it does.  The ASUS P4P800 entry is very broken.
Andrey's patches inadvertantly fix it by doing away with the
necessity for NO_MATCH entries.

		Dave

