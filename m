Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUJNWOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUJNWOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUJNWOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:14:00 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:46484 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S267411AbUJNVxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:53:55 -0400
Subject: Re: Fw: signed kernel modules?
From: David Woodhouse <dwmw2@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410142331020.877@scrub.home>
References: <Pine.LNX.4.61.0410132346080.7182@scrub.home>
	 <1097626296.4013.34.camel@localhost.localdomain>
	 <1096411448.3230.22.camel@localhost.localdomain>
	 <1092403984.29463.11.camel@bach> <19388.1092301990@redhat.com>
	 <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
	 <27277.1097702318@redhat.com> <16349.1097752349@redhat.com>
	 <Pine.LNX.4.61.0410141357380.877@scrub.home>
	 <1097755890.318.700.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.61.0410141554330.877@scrub.home>
	 <1097764251.318.724.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.61.0410142256360.877@scrub.home>
	 <1097789060.5788.2001.camel@baythorne.infradead.org>
	 <Pine.LNX.4.61.0410142331020.877@scrub.home>
Content-Type: text/plain
Message-Id: <1097790753.5788.2031.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 14 Oct 2004 22:52:33 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 23:36 +0200, Roman Zippel wrote:
> No. I still don't know, why the kernel has to do this? You avoided to 
> answer this question already before.

Partly to protect against accidentally-corrupted modules causing damage.
Partly to allow a sysadmin (or more likely an IT department) to enforce
a policy that only known and approved modules shall be loaded onto
machines which they're expected to support. Partly to allow other
support providers to do likewise, or at least to _detect_ the fact that
unsupported modules are loaded.

-- 
dwmw2


