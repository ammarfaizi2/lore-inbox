Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265062AbUELNlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUELNlU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUELNlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:41:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41857 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265048AbUELNhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:37:50 -0400
Date: Wed, 12 May 2004 09:37:41 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Michal Ludvig <michal@logix.cz>
cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
In-Reply-To: <Pine.LNX.4.53.0405111854180.10474@maxipes.logix.cz>
Message-ID: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004, Michal Ludvig wrote:

> Second patch - now the PadLock-specific part.

Can you please just follow the model of arch/s390/crypto/ ?

This is arch-specific hardware, and should not need any changes to the
existing crypto API at this stage.


- James
-- 
James Morris
<jmorris@redhat.com>


