Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265674AbTGHKBD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 06:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbTGHKBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 06:01:03 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:55288 "EHLO gaston")
	by vger.kernel.org with ESMTP id S265674AbTGHKBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 06:01:02 -0400
Subject: Re: [PATCH] timer clean up for i2c-keywest.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <16137.6948.764603.59450@cargo.ozlabs.ibm.com>
References: <16137.6948.764603.59450@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057659314.11708.110.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 08 Jul 2003 12:15:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-07 at 09:03, Paul Mackerras wrote:
> This patch changes i2c-keywest.c to use mod_timer instead of a
> two-line sequence to compute .expires and call add_timer in 3 places.
> Without this patch I get a BUG from time to time in add_timer.

Hrm... I did a different fix for this problem in 2.4, patch
against 2.5 coming in a few minutes...

Ben.

