Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVCGX51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVCGX51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVCGXz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:55:28 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:29090 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261278AbVCGXjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:39:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AROV1CxrINjwuq7AJ6FpqDjD6Vher1IpIUpjR78x+wctPrjfXSpt7Q/4fyYXIrnyfDybawbXKAEjvufkFCzbTsHUqZnChXo2f19C95ReF6JuhebMGlMo2pZ73BU2FB5TQQSMBUr0hQmGVDdMt7lODXQWFXWB4aBBErqwtIcs89k=
Message-ID: <9e47339105030715395b7bc61e@mail.gmail.com>
Date: Mon, 7 Mar 2005 18:39:42 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC][PATCH] PCI bridge driver rewrite (rev 02)
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <1110234742.2456.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1110234742.2456.37.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How is sys/bus/platform/* going to work for IA64 machine line SGI SVN?
SVN supports multiple simultaneously active legacy spaces, that means
that there can be multiple floppy, serial, ps/2, etc controllers.
Should these devices be hung off from the bridge they are on?

-- 
Jon Smirl
jonsmirl@gmail.com
