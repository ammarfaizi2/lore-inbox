Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUEJPzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUEJPzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264822AbUEJPzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:55:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264750AbUEJPzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:55:13 -0400
Date: Mon, 10 May 2004 11:55:04 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Michal Ludvig <michal@logix.cz>
cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
In-Reply-To: <Pine.LNX.4.53.0405101628080.27527@maxipes.logix.cz>
Message-ID: <Xine.LNX.4.44.0405101152550.1943-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Michal Ludvig wrote:

> It adds two new config options in the Cryptography section and if
> these are selected, aes.ko is built with the support for PadLock ACE.
> It can always be disabled with 'disable_via_padlock=1' module option
> in this case, or if the PadLock is not found in the CPU, aes.ko
> reverts to the software encryption.

We really need a proper framework for this (i.e. per-arch hardware and asm
support), not just hacks to the software AES module.


- James
-- 
James Morris
<jmorris@redhat.com>


