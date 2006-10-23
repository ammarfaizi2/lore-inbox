Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751877AbWJWK0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbWJWK0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWJWK0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:26:54 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:3002 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751877AbWJWK0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:26:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Thaw userspace and kernel space separately.
Date: Mon, 23 Oct 2006 12:26:03 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <1161560896.7438.67.camel@nigel.suspend2.net>
In-Reply-To: <1161560896.7438.67.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231226.03718.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 01:48, Nigel Cunningham wrote:
> Modify process thawing so that we can thaw kernel space without thawing
> userspace, and thaw kernelspace first. This will be useful in later
> patches, where I intend to get swsusp thawing kernel threads only before
> seeking to free memory.

Please explain why you think it will be necessary/useful.

I remember a discussion about it some time ago that didn't indicate
we would need/want to do this.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
