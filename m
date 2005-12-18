Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbVLRD1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbVLRD1L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVLRD1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:27:10 -0500
Received: from ns.suse.de ([195.135.220.2]:9873 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965055AbVLRD1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:27:09 -0500
To: Robert Walsh <rjwalsh@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 03/13]  [RFC] ipath copy routines
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com>
	<200512161548.lRw6KI369ooIXS9o@cisco.com>
	<20051217123833.1aa430ab.akpm@osdl.org>
	<1134859243.20575.84.camel@phosphene.durables.org>
From: Andi Kleen <ak@suse.de>
Date: 18 Dec 2005 04:27:06 +0100
In-Reply-To: <1134859243.20575.84.camel@phosphene.durables.org>
Message-ID: <p73k6e3dr05.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Walsh <rjwalsh@pathscale.com> writes:
> 
> Any chance we could get these moved into the x86_64 arch directory,
> then?  We have to do double-word copies, or our chip gets unhappy.

Standard memcpy will do double word copies if everything is suitably
aligned. Just use that.

-Andi
