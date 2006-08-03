Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWHCOGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWHCOGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWHCOGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:06:00 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:28827 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932496AbWHCOF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:05:59 -0400
Date: Thu, 3 Aug 2006 16:05:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 4/33] i386: CONFIG_PHYSICAL_START cleanup
Message-ID: <20060803140512.GA9815@mars.ravnborg.org>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <11544302312298-git-send-email-ebiederm@xmission.com> <20060801190838.GB12573@mars.ravnborg.org> <m164hbru7e.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m164hbru7e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Stupid questions:
> - Why do we still have a linux/config.h if it is totally redundant.
> - Why don't we have at least a #warning in linux/config.h that would
>   tell us not to include it.
> - Why do we still have about 200 includes of linux/config.h in the
>   kernel tree?
> 
> I would much rather have a compile error, or at least a compile
> warning rather than needed a code review to notice this error.
In progress. As part of the ongoing header cleanup all include
<config.h> are being removed and a warning is included in config.h.

When the change was done I did not want to spew out thousands of warning
for a simple thing like this.

	Sam
