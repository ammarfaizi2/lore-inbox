Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbUC2Veb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbUC2Veb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:34:31 -0500
Received: from dsl081-235-061.lax1.dsl.speakeasy.net ([64.81.235.61]:23461
	"EHLO ground0.sonous.com") by vger.kernel.org with ESMTP
	id S263091AbUC2Ve0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:34:26 -0500
In-Reply-To: <20040329212832.GB26854@devserv.devel.redhat.com>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <1080594005.3570.12.camel@laptop.fenrus.com> <50DC82B4-81C5-11D8-A0A8-000A959DCC8C@sonous.com> <1080595343.3570.15.camel@laptop.fenrus.com> <ACFAE876-81C7-11D8-A0A8-000A959DCC8C@sonous.com> <20040329212832.GB26854@devserv.devel.redhat.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D8E351AF-81C8-11D8-A0A8-000A959DCC8C@sonous.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Lev Lvovsky <lists1@sonous.com>
Subject: Re: older kernels + new glibc?
Date: Mon, 29 Mar 2004 13:34:23 -0800
To: Arjan van de Ven <arjanv@redhat.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 29, 2004, at 1:28 PM, Arjan van de Ven wrote:
>> perfect - where does this variable get set?  sorry for what now seems
>> like OT glibc stuff.
>
> it's passed to glibc ./configure at build time; if you have an rpm 
> based
> distro you'll see it in the specfile of the src.rpm

ok, so this presents a bit of a problem in that case (assuming I'm 
understanding you) - I'm working backwards in this respect, as I'm 
using the "new" version of glibc, and an older version of the kernel 
than the one that glibc was told to remain compatible with - the 
important question, is does this order of operations (possibly) break 
things, or does the fact that I compiled the kernel on this new version 
of glibc remove any issues.

thanks,
-lev

