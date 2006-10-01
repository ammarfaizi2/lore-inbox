Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWJAUW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWJAUW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWJAUW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:22:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53148 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932307AbWJAUWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:22:55 -0400
Subject: Re: [PATCH] - add PNP IDs for FPI based touchscreens
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061001182738.GA17124@srcf.ucam.org>
References: <20061001182738.GA17124@srcf.ucam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 01 Oct 2006 21:47:39 +0100
Message-Id: <1159735659.13029.182.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-01 am 19:27 +0100, ysgrifennodd Matthew Garrett:
> The Compaq TC1000 and Fujitsu Stylistic range of tablet machines use 
> touchscreens from FPI. These are implemented as serial interfaces, 
> generally exposed in the ACPIPNP information on the system. This patch 
> adds them to the 8250_pnp driver tables, avoiding the need to mess 
> around with setserial to set them up.
> 
> I haven't been able to confirm what FUJ02B5, FUJ02BA and FUJ02BB are. 
> FUJ02B1 refers to the controller for the system hotkeys. FUJ02BC appears 
> to be the last in the range - after this, they moved to Wacom-based 
> systems.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>


Acked-by: Alan Cox <alan@redhat.com>

This makes a lot of sense and will mean that people don't have to read
the fpit driver docs to get X working.

Alan

