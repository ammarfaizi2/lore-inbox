Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVBNK47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVBNK47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 05:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVBNK47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 05:56:59 -0500
Received: from sd291.sivit.org ([194.146.225.122]:34003 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261412AbVBNK45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 05:56:57 -0500
Date: Mon, 14 Feb 2005 11:58:37 +0100
From: Stelian Pop <stelian@popies.net>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050214105837.GE3233@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20050210161809.GK3493@crusoe.alcove-fr> <E1D0dqo-00041G-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D0dqo-00041G-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 10:53:10AM +0000, Matthew Garrett wrote:

> Stelian Pop <stelian@popies.net> wrote:
> 
> > Privately I've had many positive feedbacks from users of this driver
> > (and no negative feedback), including Linux distributions who wish
> > to include it into their kernels. The reports are increasing in number,
> > it would seem that newer Sony Vaios are more and more incompatible
> > with sonypi and require sony_acpi to control the screen brightness.
> 
> The sonypi driver seems to be necessary to catch Vaio hotkey events,
> including the sleep button. I've checked a couple of DSDTs, and it seems
> that the more recent Vaios are lacking the SPIC entries but still don't
> have the sleep button defined. Is there any chance of this driver being
> able to catch hotkey events?

I don't believe so.

> Related to that, I have a nastyish hack which lets the sonypi driver
> generate ACPI events whenever a hotkey is pressed. Despite not strictly
> being ACPI events, this makes it much easier to integrate sonypi stuff
> with general ACPI support. I'll send it if you're interested.

Wouldn't be more useful to make the ACPI hotkeys generate an
input event (like sonypi does) and integrate all this at the input
level ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>
