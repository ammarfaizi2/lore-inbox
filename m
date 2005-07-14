Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVGOAAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVGOAAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbVGNX65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:58:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262813AbVGNX4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:56:45 -0400
Date: Thu, 14 Jul 2005 16:55:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Message-Id: <20050714165551.1ff54dd3.akpm@osdl.org>
In-Reply-To: <200507140912.22532.mgross@linux.intel.com>
References: <200507140912.22532.mgross@linux.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Gross <mgross@linux.intel.com> wrote:
>
> I know this is a broken record, but the development process within the LKML 
>  isn't resulting in more stable and better code.  Some process change could be 
>  a good thing.

We rely upon people (such as mgross@linux.intel.com!) to send bug reports.

>  Why does my alps mouse pad have to stop working every time I test a new 
>  "STABLE" kernel?  

The alps driver is always broken.  Seems to be a feature.

Please test 2.6.13-rc3 and if it also fails send a comprehensive bug report
to Dmitry Torokhov <dtor_core@ameritech.net> and Vojtech Pavlik
<vojtech@suse.cz>

>  Why does swsup have to start hanging on shut and startup down randomly?

swsusp also is a problematic feature.  You appear to have chosen two of the
very most problematic parts of the kernel (you missed ACPI) and then
generalised them to the whole.  That isn't valid.

Please test 2.6.13-rc3 and if it also fails send a comprehensive bug report
to Pavel Machek <pavel@ucw.cz>
