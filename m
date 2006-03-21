Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbWCUWU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWCUWU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWCUWU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:20:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54405 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965138AbWCUWUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:20:25 -0500
Date: Tue, 21 Mar 2006 17:20:16 -0500
From: Dave Jones <davej@redhat.com>
To: Sasa Ostrouska <sasa.ostrouska@volja.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: p4-clockmod not working in 2.6.16
Message-ID: <20060321222016.GB8583@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sasa Ostrouska <sasa.ostrouska@volja.net>,
	linux-kernel@vger.kernel.org
References: <1142974528.3470.4.camel@localhost> <20060321210106.GA25370@redhat.com> <1142978230.3470.12.camel@localhost> <20060321220115.GA8583@redhat.com> <1142979226.3470.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142979226.3470.18.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 11:13:45PM +0100, Sasa Ostrouska wrote:

 > Patch failed :(
 > 
 > root@rc-vaio:/usr/src/linux-2.6.16# patch -p1 < ../linux-2.6.16-p4-clockmod.diff
 > patching file arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
 > Hunk #1 FAILED at 244.
 > 1 out of 1 hunk FAILED -- saving rejects to file arch/i386/kernel/cpu/cpufreq/p4-clockmod.c.rej
 > root@rc-vaio:/usr/src/linux-2.6.16#

Something isn't right with your tree. Are you sure that's a 2.6.16 ?

(17:19:17:davej@linux-2.6.16)$ patch -p1 --dry-run < ~/cf
patching file arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
(17:19:24:davej@linux-2.6.16)$

		Dave

-- 
http://www.codemonkey.org.uk
