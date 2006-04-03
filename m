Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751715AbWDCKAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWDCKAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 06:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbWDCKAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 06:00:40 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:42219 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751712AbWDCKAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 06:00:39 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: rachita@in.ibm.com
Subject: Re: 2.6.16-mm2 fails to boot on a x86_64 box
Date: Mon, 3 Apr 2006 11:59:49 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060403070643.GA18648@in.ibm.com>
In-Reply-To: <20060403070643.GA18648@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604031159.49953.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 03 April 2006 09:06, Rachita Kothiyal wrote:
> I was trying to boot to a 2.6.16-mm2 kernel on a
> x86_64 machine, but the kernel panic'd with the
> attached output.
> 
> Any ideas?

I'd try to change the I/O scheduler and see what happens.  If it works,
the CFQ is probably at falut.

Greetings,
Rafael
