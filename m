Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVAYWKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVAYWKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVAYWHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:07:23 -0500
Received: from orb.pobox.com ([207.8.226.5]:32974 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262181AbVAYWCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:02:42 -0500
Date: Tue, 25 Jan 2005 14:02:29 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
Message-ID: <20050125220229.GB5726@ip68-4-98-123.oc.oc.cox.net>
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com> <1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com> <m1sm4phpor.fsf@ebiederm.dsl.xmission.com> <20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net> <m1brbdhl3l.fsf@ebiederm.dsl.xmission.com> <20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net> <m13bwphflw.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13bwphflw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 05:12:43AM -0700, Eric W. Biederman wrote:
> Could you try this patch on your system with acpi that
> is having problems.
> 
> The patch needs some work before it goes into a mainline kernel
> as I have hacked the call to acpi_power_off_prepare into roughly
> the proper position in the call chain instead of use a proper
> hook.  But I can't quickly find an existing hook in the proper
> location.

I had to fix a couple of typos ("apci" and "offf") to get it to compile.
Once I did that, the patch made shutdown work again.

-Barry K. Nathan <barryn@pobox.com>

