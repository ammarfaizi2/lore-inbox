Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVGZUDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVGZUDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVGZUDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:03:30 -0400
Received: from tangens.sinus.cz ([195.39.17.8]:7882 "HELO tangens.sinus.cz")
	by vger.kernel.org with SMTP id S261990AbVGZUDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:03:25 -0400
Date: Tue, 26 Jul 2005 22:03:03 +0200
From: Pavel Troller <patrol@sinus.cz>
To: Len Brown <len.brown@intel.com>
Cc: Cameron Harris <thecwin@gmail.com>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: ACPI buttons in 2.6.12-rc4-mm2
Message-ID: <20050726200303.GA32581@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mail-Followup-To: Pavel Troller <patrol@sinus.cz>,
	Len Brown <len.brown@intel.com>, Cameron Harris <thecwin@gmail.com>,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <b6d0f5fb0505220425146d481a@mail.gmail.com> <1122407079.13241.4.camel@toshiba.lenb.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122407079.13241.4.camel@toshiba.lenb.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I deleted /proc/acpi/button on purpose,
> did you have a use for those files?
> 
Hi Len!
  I already wrote 2 mails that I have use for the LID switch status file and
that I don't know how to handle its absence. However, they seem to be dropped
on the floor somewhere :-).
  BTW I have written a small C program which uses dev_acpi module and
evaluates an object, which I'm using to evaluade the _LID method, thus reading
the status of the switch. However, I think that this should be done by the
kernel. So at least, if the buttons allow to read their status, I'm voting for
keeping the possibility to read it.
                                  With regards, Pavel Troller
