Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270595AbTGTB4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 21:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270596AbTGTB4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 21:56:25 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:16389 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S270595AbTGTB4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 21:56:05 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	<3F16C190.3080205@pobox.com>
	<200307171756.19826.schlicht@uni-mannheim.de>
	<3F16C83A.2010303@pobox.com>
	<20030717125942.7fab1141.davem@redhat.com>
	<1058477803.754.11.camel@ezquiel.nara.homeip.net>
	<20030717144031.3bbacee5.davem@redhat.com>
	<m3isq0d0wi.fsf@lugabout.jhcloos.org>
	<20030717222651.2747a93e.davem@redhat.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030717222651.2747a93e.davem@redhat.com>
Date: 19 Jul 2003 22:10:57 -0400
Message-ID: <m3oezqx80e.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> I really think [ipv6] is the issue, try to eliminate it from your
David> environment to verify.

Verified.  e100.ko rmmod(8)ed fine when ipv6 was not compiled in.

The netfilters and ppp0 were up; v6 ws the only variable.

-JimC

