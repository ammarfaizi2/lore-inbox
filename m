Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270855AbUJUVPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270855AbUJUVPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270838AbUJUVL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:11:58 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:60180 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270936AbUJUUmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:42:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FLtpiudvs9n/uN07sX14YyjKUzaw3LWbsguVds6+GPuz5rPrZ9X/YzadRvSwmtAvBssKT2xb4WhBvX3ytT8MGQdB/JgyBXAzektHIUJ4RBPGsRfbNdGIn05Y1fZrPzZ3+aCXAJvoidtA2/QknsxEKnngr4yIC0jlMQTh1HZvvtI=
Message-ID: <58cb370e041021134269c05f17@mail.gmail.com>
Date: Thu, 21 Oct 2004 22:42:18 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE CF adaptor
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <41781B13.3030803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41780393.3000606@rtr.ca>
	 <58cb370e041021121317083a3a@mail.gmail.com> <41781B13.3030803@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 16:24:51 -0400, Mark Lord <lkml@rtr.ca> wrote:
> Okay, patch withdrawn.
> 
> I'll just apply it to my own kernels for my own use.

Just port it to 2.6.x...

> Whatever happended to the days when Linux *wanted* more
> drivers and such?

New drivers are still welcomed... but days of applying
new drivers without any complaints are long gone... ;-)

Now speaking seriously:
* 2.4.x is deprecated (sorry, Marcelo ;)
* this driver shouldn't require much work to port it to 2.6.x
* ide_unregister() is disallowed, unless IDE locking is fixed

Cheers,
Bartlomiej
