Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbUCNXde (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 18:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUCNXde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 18:33:34 -0500
Received: from cmsrelay01.mx.net ([165.212.11.110]:42128 "HELO
	cmsrelay01.mx.net") by vger.kernel.org with SMTP id S262058AbUCNXcd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 18:32:33 -0500
X-USANET-Auth: 165.212.8.2     AUTO ebrower@usa.net uwdvg002.cms.usa.net
Date: Sun, 14 Mar 2004 15:32:27 -0800
From: Eric <ebrower@usa.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Re: [PATCH] ethtool.h should use userspace-accessible types]
CC: <linux-kernel@vger.kernel.org>
X-Mailer: USANET web-mailer (CM.0402.7.03)
Mime-Version: 1.0
Message-ID: <816icNXGb5200S02.1079307147@uwdvg002.cms.usa.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:

> Eric Brower wrote:
> > Attached is a patch to 2.4's ethtool.h to use appropriate, 
> > userspace-accessible data types (__u8 and friends, rather than u8 and 
> > friends).
> 
> I'm happy with u8/u16/u32, so it stays that way :)

I'm not arguing about a personal, stylistic preference-- these differing types
have been provided for a reason and the ethtool header file should comply with
the stated and idiomatic usage within the kernel sources, as do other such
header files.

Without such a change, userspace applications cannot use the ethtool ioctl
interface without completely unnecessary gyrations.  I truly appreciate your
preference, but this has nothing to do with style.

E


