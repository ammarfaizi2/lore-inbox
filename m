Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVCPOaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVCPOaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVCPOaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:30:55 -0500
Received: from aun.it.uu.se ([130.238.12.36]:53438 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262595AbVCPOaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:30:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16952.17154.477852.299855@alkaid.it.uu.se>
Date: Wed, 16 Mar 2005 15:30:26 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Mikael Starvik" <mikael.starvik@axis.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][2.4.30-pre1] preliminary fixes for gcc-4.0
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801B763B2@exmail1.se.axis.com>
References: <BFECAF9E178F144FAEF2BF4CE739C668014C77ED@exmail1.se.axis.com>
	<BFECAF9E178F144FAEF2BF4CE739C66801B763B2@exmail1.se.axis.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Starvik writes:
 > Another comment:
 > 
 > >CFLAGS += -ffreestanding to avoid gcc magically turning sprintf()
 > >  into calls to non-existent strcpy().
 > 
 > You could use -fno-builtin-sprintf instead and thus also avoid the abs
 > change.

Cool. I'll test that and if it works w/o exposing other breakage hidden
by -ffreestanding I'll drop the abs() changes.

Thanks.

/Mikael
