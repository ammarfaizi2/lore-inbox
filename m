Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264523AbTFEJHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 05:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTFEJHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 05:07:42 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:62349 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S264523AbTFEJHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 05:07:41 -0400
Date: Thu, 5 Jun 2003 11:21:11 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: Mark Watts <m.watts@eris.qinetiq.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc7-ac1
In-Reply-To: <200306051002.54089.m.watts@eris.qinetiq.com>
Message-ID: <Pine.LNX.4.44.0306051117050.24047-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jun 2003, Mark Watts wrote:

> I wonder if you could confirm whether the usb-ohci module should be loaded
> automatically if I have the following line in modules.conf (this is with
> 2.4.21-rc6-ac2)
>
> probeall usb-interface usb-ohci

No. You have to modprobe 'usb-interface' somewhere in your rc scripts.
See the manpage for modules.conf

What distribution are you using?

In debian, /etc/modules contains the modules, which are loaded at system
startup.

Regards,

  Geller Sandor

