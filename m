Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUHSK4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUHSK4B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 06:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUHSK4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 06:56:01 -0400
Received: from [80.188.250.22] ([80.188.250.22]:64716 "EHLO
	thinkpad.gardas.net") by vger.kernel.org with ESMTP id S265098AbUHSKz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 06:55:59 -0400
Date: Thu, 19 Aug 2004 12:55:47 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@thinkpad.gardas.net
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: IBM T22/APM suspend does not work with yenta_socket module loaded
 on 2.6.8.1
In-Reply-To: <20040819105508.E546@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.43.0408191254590.1006-100000@thinkpad.gardas.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, Russell King wrote:

> On Thu, Aug 19, 2004 at 11:46:53AM +0200, Karel Gardas wrote:
> > I hope I have not make any mistake, but diff seems to be pretty bigger:
>
> Ok, could you try commenting out the call to pci_set_power_state() in
> yenta_dev_suspend() please?  I wonder if your BIOS doesn't like us
> placing the cardbus bridge into D3.

Right! Doing this solved my issue.

Thanks,

Karel
--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com

