Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTL0Shu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 13:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTL0Shu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 13:37:50 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:5804 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264534AbTL0Shs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 13:37:48 -0500
Date: Sat, 27 Dec 2003 19:37:04 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: Re: Synaptics problems in -mm1
Message-ID: <20031227183704.GD10491@louise.pinerecords.com>
References: <20031224095921.GA8147@lsc.hu> <200312271228.59192.dtor_core@ameritech.net> <20031227181120.GC10491@louise.pinerecords.com> <200312271323.22252.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312271323.22252.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-27 2003, Sat, 13:23 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> > mice: PS/2 mouse device common for all mice
> > input: PC Speaker
> > synaptics reset failed
> > synaptics reset failed
> > synaptics reset failed
> 
> Ok, are you running with cpufreq?

Yes, but
	1) I've been on AC all the time.
	2) 2.6.0 works.

> I think it ACPI PM timer if you have it activated - I am having problems
> with it myself but didn't have time to look closer.  Could you try booting
> with clock=tsc or clock=pit and see if it fixes the touchpad.

clock=tsc		appears to fix the problem.
clock=pit		no change.

-- 
Tomas Szepe <szepe@pinerecords.com>
