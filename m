Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUBZQP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbUBZQP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:15:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16831 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262802AbUBZQOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:14:36 -0500
Date: Thu, 26 Feb 2004 11:14:55 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to use cipher algorithms in the kernel?
In-Reply-To: <001b01c3fc7d$9e265650$0e25fe96@pysiak>
Message-ID: <Xine.LNX.4.44.0402261113290.6954-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Maciej Soltysiak wrote:

> Hi,
> 
> are the cipher algorithms in the kernel to be used by any userspace
> aplication?
> eg. I were to write a program that would need to cipher a message, would
> it be a good way to try to use something like CONFIG_CRYPTO_CAST5 ?
> 
> If so, is there an api explained somewhere?

No, why would you want to use the kernel crypto when you can just use 
userspace crypto.

Where it will make sense in some cases is when there is crypto hardware 
support in the kernel.


- James
-- 
James Morris
<jmorris@redhat.com>


