Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423028AbWANEmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423028AbWANEmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 23:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423035AbWANEmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 23:42:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34012 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423028AbWANEmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 23:42:11 -0500
Date: Fri, 13 Jan 2006 23:41:52 -0500
From: Dave Jones <davej@redhat.com>
To: Philipp Rumpf <prumpf@gmail.com>
Cc: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060114044152.GA3127@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Philipp Rumpf <prumpf@gmail.com>, Con Kolivas <kernel@kolivas.org>,
	ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <e5bb8d810601131942r53712423kbd924757195f398b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5bb8d810601131942r53712423kbd924757195f398b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 09:42:26PM -0600, Philipp Rumpf wrote:
 > Out of curiosity, why didn't you do the monitoring using
 > /proc/acpi/battery/.../{state,info} (while running off battery)?  I
 > think that should have much finer granularity, and avoid various
 > capacitors that might be in the way and explain the effect you
 > noticed.

ACPI battery reporting seems hit-or-miss at times.
Sometimes it seems to not update for ages, and then suddenly
there's a burst when suddenly 5% of the battery drains in
seconds.   As an overall 'how much battery is left' thing it seems
ok, but I don't trust it for accurate measurements of power drain.

Whether this is a firmware deficiency causing us not to see
regular interrupts, or a problem with the acpi parser I don't know.

		Dave

