Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbTL0SX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 13:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbTL0SX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 13:23:29 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:46245 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264527AbTL0SX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 13:23:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: Synaptics problems in -mm1
Date: Sat, 27 Dec 2003 13:23:22 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
References: <20031224095921.GA8147@lsc.hu> <200312271228.59192.dtor_core@ameritech.net> <20031227181120.GC10491@louise.pinerecords.com>
In-Reply-To: <20031227181120.GC10491@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312271323.22252.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 December 2003 01:11 pm, Tomas Szepe wrote:

> mice: PS/2 mouse device common for all mice
> input: PC Speaker
> synaptics reset failed
> synaptics reset failed
> synaptics reset failed

Ok, are you running with cpufreq? I think it ACPI PM timer if you have
it activated - I am having problems with it myself but didn't have time
to look closer. Could you try booting with clock=tsc or clock=pit and
see if it fixes the touchpad.

Dmitry
