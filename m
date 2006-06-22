Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWFVQEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWFVQEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWFVQEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:04:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:7786 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161074AbWFVQEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:04:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=QJfdRngMFTrqrFl3jA1js+p/vPdzgYSAAOXpm2ROjoFxPYvrlwLIh4kV4McULi+GA8eqRGjMNc9Qg7CqloTE7zeXxgXvNs8VHIzO3kWypON7o/4M+FNKYa5Fi40tDQwUzQ7w3+dX4B42rWVLdwBux8rDsvWeeJYWF+VwJ3iUiYk=
Date: Thu, 22 Jun 2006 18:04:03 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org, stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060622160403.GB2539@slug>
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622004648.f1912e34.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 22, 2006 at 12:46:48AM -0700, Andrew Morton wrote:
> I can bisect it if we're stuck, but that'll require beer or something.

FWIW, my laptop (Dell D610) gave the following results:
2.6.17-mm1: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
2.6.17+origin.patch: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
2.6.17: oops
2.6.17.1: oops

2.6.17-rc6-mm2: suspends correctly


Regards,
Frederik
