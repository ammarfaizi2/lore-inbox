Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUHEVfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUHEVfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267875AbUHEVe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:34:56 -0400
Received: from the-village.bc.nu ([81.2.110.252]:7615 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267983AbUHEVen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:34:43 -0400
Subject: Re: OLS and console rearchitecture
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4111F624.7080605@hist.no>
References: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
	 <4111F624.7080605@hist.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091737928.8366.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 21:32:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-05 at 09:56, Helge Hafting wrote:
> Isn't the "unique VGA" a disappearing problem?

Alas not.

> Please avoid unnecessary disabling of such devices, that only causes
> trouble for those of use trying to use several screens at once. (Possibly
> with several simultaneous _users_, who don't want their screen disabled 
> for no
> good reason.) Of course one may have to buy the "right" cards when 
> setting up
> such a machine.

The goal is to have a control device to arbitrate it. This doesn't
generally cause a performance hit and X currently handles it internally
using RAC but once you have multiple uses of VGA space the arbitration
has to go kernel side

