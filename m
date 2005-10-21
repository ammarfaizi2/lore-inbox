Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbVJUIyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVJUIyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 04:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVJUIyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 04:54:13 -0400
Received: from [81.2.110.250] ([81.2.110.250]:39047 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932562AbVJUIyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 04:54:13 -0400
Subject: Re: Advantech Watchdog timer query.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ryan.clayburn@dsto.defence.gov.au
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1129880542.2194.49.camel@localhost.localdomain>
References: <1129880542.2194.49.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Oct 2005 10:22:48 +0100
Message-Id: <1129886568.26367.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-10-21 at 17:12 +0930, Ryan Clayburn wrote:
> card. Everything seems to work except when i deliberately delay the ping
> to the card to let it reboot the system as a watchdog should it does not
> reboot. Is there something i am missing. Do i need a update to the

It ought to just work. Do check the ioctl call returns when setting the
timeout do not report an error however.


