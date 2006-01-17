Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWAQBGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWAQBGh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 20:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWAQBGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 20:06:37 -0500
Received: from hell.org.pl ([62.233.239.4]:52229 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1751319AbWAQBGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 20:06:33 -0500
Date: Tue, 17 Jan 2006 02:06:17 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Hanno =?iso-8859-2?Q?B=F6ck?= <mail@hboeck.de>
Cc: Christian Aichinger <Greek0@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH] Work around asus_acpi driver oopses on Samsung P30s and the like due to the ACPI implicit return
Message-ID: <20060117010616.GA22430@hell.org.pl>
Mail-Followup-To: Hanno =?iso-8859-2?Q?B=F6ck?= <mail@hboeck.de>,
	Christian Aichinger <Greek0@gmx.net>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	"Brown, Len" <len.brown@intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com> <20051223113347.GA20475@orest.greek0.net> <20051223121923.GA12918@hell.org.pl> <200601161203.23669.mail@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200601161203.23669.mail@hboeck.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Hanno Böck:
> Any news on this?

The fix is in acpi-test already, and a rework of this code is in the
acpi4asus CVS and will be sent to Len as soon as I rediff the patches
against the git tree.

As for -stable, my understanding is that Chris wants to wait for the fix to
boil in the mainline for a while.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
