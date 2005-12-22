Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVLVKyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVLVKyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 05:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVLVKyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 05:54:00 -0500
Received: from hell.org.pl ([62.233.239.4]:43013 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1750906AbVLVKx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 05:53:59 -0500
Date: Thu, 22 Dec 2005 11:53:45 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: "Brown, Len" <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Hanno B??ck <mail@hboeck.de>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Christian Aichinger <Greek0@gmx.net>
Subject: Re: asus_acpi still broken on Samsung P30/P35
Message-ID: <20051222105344.GA32356@hell.org.pl>
Mail-Followup-To: "Brown, Len" <len.brown@intel.com>,
	Linus Torvalds <torvalds@osdl.org>, Hanno B??ck <mail@hboeck.de>,
	Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Christian Aichinger <Greek0@gmx.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Brown, Len:
> Karol,
> Do you have an update of your asus driver in the pipeline
> that addresses this?

I still believe the only _right_ *workaround* is
http://bugme.osdl.org/attachment.cgi?id=6006&action=view

I'll take a shot at rediffing it against recent kernels in a couple of
hours (unless someone beats me to it).

acpi=strict will work until a suitable patch is merged.

Note: it's still a workaround, to properly fix this we need to make ACPI
interpreter behave predictably, as written in
http://bugme.osdl.org/show_bug.cgi?id=5067#c6 -- I believe I still haven't
heard from Robert Moore on the feasibility of such a solution.

Please also see http://bugme.osdl.org/show_bug.cgi?id=5067 and
http://bugzilla.kernel.org/show_bug.cgi?id=5092 for more info.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
