Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263686AbUDVIRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbUDVIRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUDVIRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:17:34 -0400
Received: from ra.sai.msu.su ([158.250.29.2]:47275 "EHLO ra.sai.msu.su")
	by vger.kernel.org with ESMTP id S263686AbUDVIRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:17:33 -0400
Date: Thu, 22 Apr 2004 12:17:28 +0400 (MSD)
From: "E.Rodichev" <er@sai.msu.su>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Direct /dev/psaux driver and relevant Kconfig changes
In-Reply-To: <200404211727.05491.dtor_core@ameritech.net>
Message-ID: <Pine.GSO.4.58.0404221210230.16437@ra.sai.msu.su>
References: <Pine.GSO.4.58.0404212031450.2778@ra.sai.msu.su>
 <200404211727.05491.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, Dmitry Torokhov wrote:

>
> The driver is not ready for kernel proper - it will not work for machines
> with active multiplexing controllers (4 AUX + KBD port) and these are quite
> common.

But this driver is optional (If unsure, say N), and many successes have been
reported. May be, we can just add a caution in help section?

E.R.
