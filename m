Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbUDARKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUDARKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:10:31 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:27617 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262986AbUDARKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:10:23 -0500
Date: Thu, 1 Apr 2004 18:10:12 +0100
From: Dave Jones <davej@redhat.com>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Message-ID: <20040401171012.GB24255@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>,
	linux-kernel@vger.kernel.org
References: <200404011900.47412.volker.hemmann@heim10.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404011900.47412.volker.hemmann@heim10.tu-clausthal.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 07:00:47PM +0200, Hemmann, Volker Armin wrote:
 > Hi,
 > 
 > in 2.6.5-rc3 was incorporated a fix for SiS648 chipsets that need a little 
 > time to get into a sane state again, after switching to AGP 8x.
 > The 746FX has the same timing problem and needs this 'pause', too.
 > Unfortunatly in sis-apg.c this fix is only checked against the 648, not the 
 > 746, so the fix never gets invoked:

Ah, yes. I actually had that in mind when I merged this code, but it
must've got paged out 8-)

Can you send lspci -n output please?

		Dave


