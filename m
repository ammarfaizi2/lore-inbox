Return-Path: <linux-kernel-owner+w=401wt.eu-S1751301AbXAOSij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbXAOSij (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXAOSij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:38:39 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:51501 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbXAOSii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:38:38 -0500
Subject: Re: [PATCH 2.6.19] USB HID: proper LED-mapping (support for
	SpaceNavigator)
From: Marcel Holtmann <marcel@holtmann.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jiri Kosina <jikos@jikos.cz>, Simon Budig <simon@budig.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20070115183207.GA6792@suse.cz>
References: <20070114231135.GA29966@budig.de>
	 <Pine.LNX.4.64.0701150938180.16747@twin.jikos.cz>
	 <20070115162541.GA3751@budig.de>
	 <Pine.LNX.4.64.0701151743170.16747@twin.jikos.cz>
	 <20070115183207.GA6792@suse.cz>
Content-Type: text/plain
Date: Mon, 15 Jan 2007 19:38:10 +0100
Message-Id: <1168886290.31200.15.camel@violet>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

> > No, it didn't disappear, it was just moved to include/linux/hid-debug.h. 
> 
> Do you think that makes sense? It's code, not a header file.
> 
> > Should I wait for an updated patch that uses hid-debug.h again?

actually that code shouldn't be in a header file at all. It should be
drivers/hid/hid-debug.c and the Makefile should compile it conditionally
depending on a Kconfig option.

Regards

Marcel


