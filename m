Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271551AbTGQVgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271568AbTGQVgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:36:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41702 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271551AbTGQVfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:35:47 -0400
Date: Thu, 17 Jul 2003 14:40:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: ricardo.b@zmail.pt
Cc: jgarzik@pobox.com, schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
Message-Id: <20030717144031.3bbacee5.davem@redhat.com>
In-Reply-To: <1058477803.754.11.camel@ezquiel.nara.homeip.net>
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	<3F16C190.3080205@pobox.com>
	<200307171756.19826.schlicht@uni-mannheim.de>
	<3F16C83A.2010303@pobox.com>
	<20030717125942.7fab1141.davem@redhat.com>
	<1058477803.754.11.camel@ezquiel.nara.homeip.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jul 2003 22:36:43 +0100
Ricardo Bugalho <ricardo.b@zmail.pt> wrote:

> Just noticed it: I can't unload the module even after bringing the
> interface down.
> In either case, modprobe hangs and I start getting this message in
> syslog:
> 
> Jul 17 21:50:44 ezquiel kernel: unregister_netdevice: waiting for eth0
> to become free. Usage count = -4
> 
> Can't shutdown the system either. Init hangs waiting for modprobe to
> die.

That's a bug we need to fix.

What driver are you using?
Are you using ipv6?
Any netfilter modules?
Anything else interesting or "unique" about your particular setup?
