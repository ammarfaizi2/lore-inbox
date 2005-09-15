Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbVIOOWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbVIOOWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbVIOOWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:22:45 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:54491 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965242AbVIOOWp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:22:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N5/3oRAPUZrcVUNQSn3w9FwXcocVzeloI0L3D/qQm9FKyBpVQ+JcVNhqktYZK8U/asaExO7i3BKzXSJPMW7TUahHDp1OvC6u2EteLu2FjEazI9+mTmgefQZ3b6lmfyhN7jX22CFrkmwrgGVlyafLVDmYyHyqL8vkb2/r063dZzQ=
Message-ID: <d120d50005091507225659868e@mail.gmail.com>
Date: Thu, 15 Sep 2005 09:22:42 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 09/28] Input: convert net/bluetooth to dynamic input_dev allocation
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>
In-Reply-To: <1126770894.28510.10.camel@station6.example.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050915070131.813650000.dtor_core@ameritech.net>
	 <20050915070302.931769000.dtor_core@ameritech.net>
	 <1126770894.28510.10.camel@station6.example.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Dmitry,
> 
> > Input: convert net/bluetooth to dynamic input_dev allocation
> >
> > This is required for input_dev sysfs integration
> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> on the condition your stuff got merged, then this patch is ok with me.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> 

I was planning on getting patch 8 (preparation patch) into kernel ASAP
and then just sending individual subsystem patches to maintainers and
Andrew so they can merge at their leisure (but don't wait for too long
;))

-- 
Dmitry
