Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbTGOTfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269633AbTGOTfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:35:40 -0400
Received: from [66.170.231.25] ([66.170.231.25]:1664 "EHLO
	euphrates.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id S269628AbTGOTfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:35:39 -0400
To: lkml@brodo.de
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.6.0-test1 - cpu_freg sysfs nodes?
References: <20030715175010.CE2428275@voodoo.strato-webmail.de>
From: ian.soboroff@nist.gov
Date: Tue, 15 Jul 2003 16:50:19 -0400
In-Reply-To: <20030715175010.CE2428275@voodoo.strato-webmail.de> (lkml@brodo.de's
 message of "Tue, 15 Jul 2003 19:50:10 +0200 (CEST)")
Message-ID: <m3n0ffbjlg.fsf@euphrates.ncsl.nist.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml@brodo.de writes:

> There is a problem with the proper detection of longrun CPUs, see this
> patch please [davej: can you appply this to your tree, too, please?]
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105797182628099&w=2
>
>     Dominik

This patch solves it for me.  Now I have all the cpufreq nodes in
sysfs, and the old /proc interface works as well (meaning I don't have
to rewrite /etc/sysconfig/apm-scripts/apmcontinue ;-)

Thanks!
Ian

