Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWIVBB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWIVBB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 21:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWIVBB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 21:01:57 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:57787 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932156AbWIVBB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 21:01:56 -0400
Subject: Re: [PATCH -mm 0/6] swsusp: Add support for swap files
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200609202120.58082.rjw@sisk.pl>
References: <200609202120.58082.rjw@sisk.pl>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 11:01:53 +1000
Message-Id: <1158886913.15894.31.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-09-20 at 21:20 +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> The following series of patches makes swsusp support swap files.
> 
> For now, it is only possible to suspend to a swap file using the in-kernel
> swsusp and the resume cannot be initiated from an initrd.

I'm trying to understand 'resume cannot be initiated from an initrd'.
Does that mean if you want to use this functionality, you have to have
everything needed compiled in to the kernel, and it's not compatible
with LVM and so on?

Regards,

Nigel

