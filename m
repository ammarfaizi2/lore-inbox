Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVAYWTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVAYWTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVAYWRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:17:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60885 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262180AbVAYWOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:14:05 -0500
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com>
	<m1sm4phpor.fsf@ebiederm.dsl.xmission.com>
	<20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net>
	<m1brbdhl3l.fsf@ebiederm.dsl.xmission.com>
	<20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net>
	<m13bwphflw.fsf@ebiederm.dsl.xmission.com>
	<20050125220229.GB5726@ip68-4-98-123.oc.oc.cox.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jan 2005 15:12:00 -0700
In-Reply-To: <20050125220229.GB5726@ip68-4-98-123.oc.oc.cox.net>
Message-ID: <m1651lupjj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" <barryn@pobox.com> writes:

> On Tue, Jan 25, 2005 at 05:12:43AM -0700, Eric W. Biederman wrote:
> > Could you try this patch on your system with acpi that
> > is having problems.
> > 
> > The patch needs some work before it goes into a mainline kernel
> > as I have hacked the call to acpi_power_off_prepare into roughly
> > the proper position in the call chain instead of use a proper
> > hook.  But I can't quickly find an existing hook in the proper
> > location.
> 
> I had to fix a couple of typos ("apci" and "offf") to get it to compile.
> Once I did that, the patch made shutdown work again.

Thanks.  Now I just need to come up with the good version unless one of
the acpi guys wants to volunteer.

Eric
