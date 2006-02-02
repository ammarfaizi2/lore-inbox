Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWBBWoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWBBWoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWBBWoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:44:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61078 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932407AbWBBWoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:44:14 -0500
Date: Thu, 2 Feb 2006 17:43:47 -0500
From: Dave Jones <davej@redhat.com>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Tony Lindgren <tony@atomide.com>, "Brown, Len" <len.brown@intel.com>,
       Erik Slagter <erik@slagter.name>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Message-ID: <20060202224347.GL11831@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Tony Lindgren <tony@atomide.com>,
	"Brown, Len" <len.brown@intel.com>,
	Erik Slagter <erik@slagter.name>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20060202222407.GB896@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202222407.GB896@sommrey.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:24:07PM +0100, Joerg Sommrey wrote:

 > +- Occasional hard lockups might be caused by amd76x_pm.  I'm still working
 > +  on this issue.

We've had users report lockups, random oopses and other problems
with lvcool and amd76x_pm in the past, that went away when the
module.  The lack of understanding of this problem makes me inclined
to say that this shouldn't get merged upstream until it's solved.

If it does get merged, it's not something I intend to enable
in a distro kernel for some time, if at all.

		Dave

