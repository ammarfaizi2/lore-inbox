Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271571AbTGQWOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271600AbTGQWNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:13:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5095 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271596AbTGQWL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:11:59 -0400
Date: Thu, 17 Jul 2003 15:16:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: ricardo.b@zmail.pt
Cc: jgarzik@pobox.com, schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
Message-Id: <20030717151647.01e790ea.davem@redhat.com>
In-Reply-To: <1058480636.754.31.camel@ezquiel.nara.homeip.net>
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	<3F16C190.3080205@pobox.com>
	<200307171756.19826.schlicht@uni-mannheim.de>
	<3F16C83A.2010303@pobox.com>
	<20030717125942.7fab1141.davem@redhat.com>
	<1058477803.754.11.camel@ezquiel.nara.homeip.net>
	<20030717144031.3bbacee5.davem@redhat.com>
	<1058480636.754.31.camel@ezquiel.nara.homeip.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jul 2003 23:23:57 +0100
Ricardo Bugalho <ricardo.b@zmail.pt> wrote:

> Netfilter no, IPv6 yes.

There are some heavy device leaks in 2.6.0-test1 as released,
if you could test something more current it would be appreciated
as we believe we have fixed this.

Alternatively, you could test if ipv6 is the culprit by removing
it from your setup somehow.
