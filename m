Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVCCTsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVCCTsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVCCTn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:43:57 -0500
Received: from smtpout1.uol.com.br ([200.221.4.192]:5589 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S261384AbVCCThi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:37:38 -0500
Date: Thu, 3 Mar 2005 16:37:13 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Andrew Hendry <ahendry@tusc.com.au>
Cc: Herbert Poetzl <herbert@13thfloor.at>, eis@baty.hanse.de,
       linux-x25@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: x25_create initializing socket data twice ...
Message-ID: <20050303193712.GC1587@cathedrallabs.org>
References: <20050303011413.GB11516@mail.13thfloor.at> <1109820054.3014.146.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109820054.3014.146.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> On the same path sk_set_owner also gets called twice, I think this
> causes double module use count when creating sockets. Module use count
> need some attention all over x25.
I'm working on it already. I hope to send patches soon.

Is linux-x25 list alive? if not, perhaps we should add netdev to Cc.

--
Aristeu

