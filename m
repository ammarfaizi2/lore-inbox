Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUFUDus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUFUDus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 23:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUFUDus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 23:50:48 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:65497 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264238AbUFUDup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 23:50:45 -0400
Date: Sun, 20 Jun 2004 23:52:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-bk way too fast
In-Reply-To: <40D657B7.8040807@pobox.com>
Message-ID: <Pine.LNX.4.58.0406202348040.3273@montezuma.fsmlabs.com>
References: <40D64DF7.5040601@pobox.com> <40D657B7.8040807@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Jeff Garzik wrote:

> Jeff Garzik wrote:
> >
> > Something is definitely screwy with the latest -bk.  I updated from a
> > kernel ~1 week ago, and all timer-related stuff is moving at a vastly
> > increased rate.  My guess is twice as fast.  Most annoying is the system
> > clock advances at twice normal rate, and keyboard repeat is so sensitive
> > I am spending quite a bit of time typing this message, what with having
> > to delettte (<== example) extra characters.  Double-clicking is also
> > broken :(
>
> Looks like disabling CONFIG_ACPI fixes things.  Narrowing down cset now...

My suspect is;

ChangeSet 1.1731 2004/06/18 01:56:40 len.brown@intel.com
  Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
  into intel.com:/home/lenb/bk/linux-acpi-test-2.6.7
