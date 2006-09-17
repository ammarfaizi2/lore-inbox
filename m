Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWIQAGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWIQAGs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 20:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWIQAGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 20:06:48 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:45025 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964876AbWIQAGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 20:06:47 -0400
Subject: Re: show all modules which taint the kernel ?
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: devzero@web.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060916234622.GA28649@redhat.com>
References: <1313042030@web.de>  <20060916234622.GA28649@redhat.com>
Content-Type: text/plain
Date: Sat, 16 Sep 2006 20:07:49 -0400
Message-Id: <1158451669.27690.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 19:46 -0400, Dave Jones wrote:
> On Sat, Sep 16, 2006 at 08:58:20PM +0200, devzero@web.de wrote:
>  > but that "Modules linked in: radeon(U) drm(U) ipv6(U) autofs4(U)...." message has been reported to originate from a fc5 (fedora) kernel. fedora probably also using that novell/suse extension ?
> 
> Different. The Fedora kernel reports U for modules that weren't shipped with
> the Fedora kernel. (It uses gpg signed modules).

Vendor kernels aside, would it be useful for mainline to report this
information - something like nvidia(P) in the module list?

Lee

