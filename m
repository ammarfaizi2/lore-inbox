Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVLRFgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVLRFgc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 00:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVLRFgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 00:36:32 -0500
Received: from lame.durables.org ([64.81.244.120]:7143 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S1030185AbVLRFgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 00:36:31 -0500
Subject: Re: [PATCH 03/13]  [RFC] ipath copy routines
From: Robert Walsh <rjwalsh@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <p73k6e3dr05.fsf@verdi.suse.de>
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com>
	 <200512161548.lRw6KI369ooIXS9o@cisco.com>
	 <20051217123833.1aa430ab.akpm@osdl.org>
	 <1134859243.20575.84.camel@phosphene.durables.org>
	 <p73k6e3dr05.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 21:36:29 -0800
Message-Id: <1134884189.20575.129.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 04:27 +0100, Andi Kleen wrote:
> Robert Walsh <rjwalsh@pathscale.com> writes:
> > 
> > Any chance we could get these moved into the x86_64 arch directory,
> > then?  We have to do double-word copies, or our chip gets unhappy.
> 
> Standard memcpy will do double word copies if everything is suitably
> aligned. Just use that.

This is dealing with buffers that may be passed in from user space, so
there's no guarantee of alignment for either the start address or the
length.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


