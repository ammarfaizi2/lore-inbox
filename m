Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVAYNwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVAYNwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVAYNwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:52:03 -0500
Received: from [81.2.110.250] ([81.2.110.250]:56475 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261938AbVAYNt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:49:26 -0500
Subject: Re: i8042 access timings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200501250241.14695.dtor_core@ameritech.net>
References: <200501250241.14695.dtor_core@ameritech.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106656314.14782.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 Jan 2005 12:44:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-25 at 07:41, Dmitry Torokhov wrote:
> Hi,
> Anyway, regardless of whether access to data register should be done with
> delay as well there seem to be another timing access violation - in
> i8042_command we do i8042_wait_read which reads STR and then immediately
> do i8042_read_status to check AUXDATA bit.
> 
> Does the patch below makes any sense?

It looks right to me

