Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTK3X1A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 18:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTK3X1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 18:27:00 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:1192 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261891AbTK3X07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 18:26:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Date: Sun, 30 Nov 2003 18:26:52 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031130214612.GP2935@mail.muni.cz> <200311301728.10563.dtor_core@ameritech.net> <20031130223953.GR2935@mail.muni.cz>
In-Reply-To: <20031130223953.GR2935@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311301826.52978.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 November 2003 05:39 pm, Lukas Hejtmanek wrote:
> On Sun, Nov 30, 2003 at 05:28:10PM -0500, Dmitry Torokhov wrote:
> > Are you using ACPI? Does it work without ACPI? Do you have an
> > application that periodically polls battery state or temperature?
> > From what I've seen many laptops spend considerable amount of time in
> > BIOS when checking battery state...
>
> I'm using ACPI both in 2.4.22 and 2.6.0. I'm using battery_applet
> (gnome applet) for testing battery state.
>
> I will try it. Is acpi=off at boot time enough for that?

How often does battery_applet poll the battery? Start with polling the
battery less often, let's say every 3 minutes and see if the problem goes
away.

Dmitry
