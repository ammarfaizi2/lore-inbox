Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbTGQToz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269161AbTGQToz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:44:55 -0400
Received: from rth.ninka.net ([216.101.162.244]:40647 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S269106AbTGQToy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:44:54 -0400
Date: Thu, 17 Jul 2003 12:59:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: schlicht@uni-mannheim.de, ricardo.b@zmail.pt, linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
Message-Id: <20030717125942.7fab1141.davem@redhat.com>
In-Reply-To: <3F16C83A.2010303@pobox.com>
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	<3F16C190.3080205@pobox.com>
	<200307171756.19826.schlicht@uni-mannheim.de>
	<3F16C83A.2010303@pobox.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 12:00:58 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> David?  Does Rusty have a plan here or something?

It just works how it works and that's it.

Net devices are reference counted, anything more is superfluous.
They may be yanked out of the kernel whenever you want.
