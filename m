Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbWGIMRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWGIMRD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 08:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbWGIMRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 08:17:03 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:31133 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030466AbWGIMRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 08:17:01 -0400
Date: Sun, 9 Jul 2006 13:15:45 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Arjan van de Ven <arjan@infradead.org>, Sunil Kumar <devsku@gmail.com>,
       Bojan Smojver <bojan@rexursive.com>, Pavel Machek <pavel@ucw.cz>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060709121545.GA2736@srcf.ucam.org>
References: <20060627133321.GB3019@elf.ucw.cz> <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com> <1152377434.3120.69.camel@laptopd505.fenrus.org> <200607082125.12819.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607082125.12819.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 09:25:12PM +0200, Rafael J. Wysocki wrote:

> Now there seem to be two possible ways to go:
> 1) Drop the implementation that already is in the kernel and replace it with
> the out-of-the-tree one.

This would break existing interfaces to some extent, right? suspend2 
doesn't have the same set of tunables. I'm not sure whether this is 
something we especially care about, but it would potentially break some 
existing userland code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
