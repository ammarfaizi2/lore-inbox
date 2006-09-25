Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWIYIJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWIYIJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWIYIJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:09:44 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:45516 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751383AbWIYIJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:09:43 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode")
Date: Mon, 25 Sep 2006 10:12:10 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <20060925071338.GD9869@suse.de>
In-Reply-To: <20060925071338.GD9869@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609251012.11317.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 25 September 2006 09:13, Stefan Seyfried wrote:
> From: Stefan Seyfried <seife@suse.de>
> 
> Add an ioctl to the userspace swsusp code that enables the usage of the
> pmops->prepare, pmops->enter and pmops->finish methods (the in-kernel
> suspend knows these as "platform method"). These are needed on many machines
> to (among others) speed up resuming by letting the BIOS skip some steps or
> let my hp nx5000 recognise the correct ac_adapter state after resume again.
> 
> Signed-off-by: Stefan Seyfried <seife@suse.de>

ACK

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
