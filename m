Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755347AbWKRXEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbWKRXEG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbWKRXEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 18:04:06 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:14481 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1755347AbWKRXEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 18:04:04 -0500
Subject: Re: [PATCH 1/4] swsusp: Untangle thaw_processes
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200611182347.05656.rjw@sisk.pl>
References: <200611182335.27453.rjw@sisk.pl>
	 <200611182347.05656.rjw@sisk.pl>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 10:03:58 +1100
Message-Id: <1163891038.6787.0.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2006-11-18 at 23:47 +0100, Rafael J. Wysocki wrote:
> Move the loop from thaw_processes() to a separate function and call it
> independently for kernel threads and user space processes so that the order
> of thawing tasks is clearly visible.
> 
> Drop thaw_kernel_threads() which is never used.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Ack.

Nigel

