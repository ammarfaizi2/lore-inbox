Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271729AbTHMJx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271730AbTHMJx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:53:59 -0400
Received: from blueice1a.de.ibm.com ([194.196.100.88]:47712 "EHLO gaston")
	by vger.kernel.org with ESMTP id S271729AbTHMJx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:53:58 -0400
Subject: Re: [bug 1079] [PATCH] 2.6.0-test3: pmac ide driver doesn't compile
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Francesco Sportolari <francesco@unipg.it>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200308130934.56092.francesco@unipg.it>
References: <200308130934.56092.francesco@unipg.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060768404.596.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Aug 2003 11:53:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-13 at 09:34, Francesco Sportolari wrote:
> Hi all,
> the pmac IDE driver (drivers/ide/ppc/pmac.c) doesn't compile due to a change 
> in ide_drive_s struct.

A patch  for this driver is already in Linus mailbox fixing
that and porting the driver to the new model.

Ben.

