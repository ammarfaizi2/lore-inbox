Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbTHTTmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbTHTTmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:42:16 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:211 "EHLO mauve.demon.co.uk")
	by vger.kernel.org with ESMTP id S262201AbTHTTmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:42:15 -0400
From: root@mauve.demon.co.uk
Message-Id: <200308201940.UAA23958@mauve.demon.co.uk>
Subject: Re: Console on USB
To: rddunlap@osdl.org (Randy.Dunlap)
Date: Wed, 20 Aug 2003 20:40:19 +0100 (BST)
Cc: Valdis.Kletnieks@vt.edu, root@mauve.demon.co.uk, tmolina@cablespeed.com,
       linux-kernel@vger.kernel.org, greg@kroah.com, zwane@linuxpower.ca
In-Reply-To: <20030820110742.0cd0160a.rddunlap@osdl.org> from "Randy.Dunlap" at Aug 20, 2003 11:07:42 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, 20 Aug 2003 13:56:18 -0400 Valdis.Kletnieks@vt.edu wrote:
> 
> | On Wed, 20 Aug 2003 18:44:58 BST, root@mauve.demon.co.uk said:
> | 
> | > For laptops, might console=/dev/irda work?
> | 
> | Hmm.... <looks around>  Do I have anything handy that will *catch* stuff being
> | spewed out the irda port?  Don't think so, or I'd have built that driver....
> | 
> | Yes, might work, *if* you have hardware handy.
> 
> I don't see any console support in the irda drivers...
> How is it supposed to work?
> or do you just mean that in theory it could be made to work?

I last looked at irda, when my laptop was a 486/745, and thought that
the hardware still looked more or less like a 8250 variant.
I had previously used /dev/ttyS1 (where that was an IR port) to dump
debugging data.

Looking at the documentation for more recent hardware, I find this isn't really
the case any more for all hardware.
