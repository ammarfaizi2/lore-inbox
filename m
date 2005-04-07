Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVDGPul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVDGPul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVDGPul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:50:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29917 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262496AbVDGPug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:50:36 -0400
Date: Thu, 7 Apr 2005 11:47:32 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kay Sievers <kay.sievers@vrfy.org>
cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Ian Campbell <ijc@hellion.org.uk>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
In-Reply-To: <20050407142349.GA26743@vrfy.org>
Message-ID: <Xine.LNX.4.44.0504071145430.21159-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Kay Sievers wrote:

> Sure, but seems I need to ask again: What is the exact reason not to implement
> the muticast message multiplexing/subscription part of the connector as a
> generic part of netlink? That would be nice to have and useful for other
> subsystems too as an option to the current broadcast.

This is a good point, in general, consider generically extending Netlink 
itself instead of creating these separate things.


- James
-- 
James Morris
<jmorris@redhat.com>


