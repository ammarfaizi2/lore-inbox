Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWC3L6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWC3L6N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWC3L6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:58:12 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:25745 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S932180AbWC3L6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:58:10 -0500
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Suspend2-2.2.2 for 2.6.16.
In-Reply-To: <200603301939.45872.ncunningham@cyclades.com>
References: <200603281601.22521.ncunningham@cyclades.com> <200603292050.33622.ncunningham@cyclades.com> <200603301134.49089.rjw@sisk.pl> <200603301134.49089.rjw@sisk.pl> <200603301939.45872.ncunningham@cyclades.com>
Date: Thu, 30 Mar 2006 12:57:50 +0100
Message-Id: <E1FOvmg-0007Sx-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:

> make: *** [vbetool/lrmi.o] Error 1

LRMI will never compile on x86_64 - the kernel doesn't do vm86. It 
should be using the x86emu backend.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
