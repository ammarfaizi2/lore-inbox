Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbTDWPZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTDWPZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:25:19 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:36022 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264084AbTDWPYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:24:24 -0400
Date: Wed, 23 Apr 2003 17:34:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Patrick Mochel <mochel@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
Message-ID: <20030423153441.GD3035@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A84725A261@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A261@orsmsx401.jf.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What I mean here is that none of our drivers know how to bring 
> > back a chip as complicated as a radeon or a nvidia up from 
> > power off, this requires intimate knowledge of the chip 
> > internals, the way it's wired on a given board, etc...
> 
> All I am saying is that on Windows, the driver gets no help from the
> BIOS, APM, or ACPI, but yet it restores the video to full working
> condition. I understand that this sounds complicated, but since
> there is

It is not only complicated, we also lack docs neccessary to do that...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
