Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTJTSrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTJTSrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:47:47 -0400
Received: from hell.org.pl ([212.244.218.42]:53768 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262760AbTJTSrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:47:46 -0400
Date: Mon, 20 Oct 2003 20:47:51 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Message-ID: <20031020184750.GA26154@hell.org.pl>
Mail-Followup-To: M?ns Rullg?rd <mru@users.sourceforge.net>,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <yw1x8yngj7xg.fsf@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote M?ns Rullg?rd:
> > Suspending and resuming from S1 disables ACPI interrupts for my machine
> > (ASUS L3800C laptop). No further interrupts and events are generated,
> > /proc/interrupts shows no change w.r. to ACPI. This happens regardless of
> > whether the specific IRQ is shared or not.
> suspend, the extra buttons (I use them to fire up programs) stop
> working.  Normally, they will generate an ACPI event, that is
> processed by acpid etc.  After a suspend, each button will work once.
> If I then close and open the lid, they will work one more time, and so
> on.  Any way I can help?

Please specify the type of suspend. The situation I described only occurs
for S1 (or, echo -n standby, more specifically), and only in certain kernel
versions.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
