Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265364AbTL0Lj2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 06:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbTL0Lj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 06:39:28 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:28331 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265364AbTL0Lj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 06:39:27 -0500
Date: Sat, 27 Dec 2003 12:38:48 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: Synaptics problems in -mm1
Message-ID: <20031227113848.GA10491@louise.pinerecords.com>
References: <20031224095921.GA8147@lsc.hu> <200312250411.55881.dtor_core@ameritech.net> <200312250413.32822.dtor_core@ameritech.net> <200312250414.58598.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312250414.58598.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems one of the synaptics-related patches in 2.6.0-mm1 kills
off the pointer stick on my T40p.  2.6.0 vanilla works just fine
in that department.  Thought you might want to know.

Reverting

	input-08-synaptics-protocol-discovery.patch
	input-07-remove-synaptics-config-option.patch
	synaptics-powerpro-fix.patch

did not seem to help.  I failed to figure out a way to easily revert

	serio-06-synaptics-use-reconnect.patch
	serio-04-synaptics-cleanup.patch

so that I didn't try.

-- 
Tomas Szepe <szepe@pinerecords.com>
