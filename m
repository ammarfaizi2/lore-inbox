Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVDEFKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVDEFKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 01:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVDEFKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 01:10:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261563AbVDEFKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 01:10:25 -0400
Date: Tue, 5 Apr 2005 01:10:06 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, <rml@novell.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Netlink Connector / CBUS
In-Reply-To: <Xine.LNX.4.44.0504050030230.9273-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0504050108260.9383-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, James Morris wrote:

> A few questions:

Also, please allow cn_add_callback() allow it to be passed a NULL 
callback function, so the caller doesn't pass in a dummy function and your 
code doesn't waste time dealing with something which isn't real.


- James
-- 
James Morris
<jmorris@redhat.com>


