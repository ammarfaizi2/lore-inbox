Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUDELNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUDELNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:13:20 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:7832 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S261984AbUDELNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:13:18 -0400
Subject: Re: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
	isolation
From: Adrian Cox <adrian@humboldt.co.uk>
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: Michael Hunold <m.hunold@gmx.de>, Greg KH <greg@kroah.com>
In-Reply-To: <20040403163031.122b5df8.khali@linux-fr.org>
References: <40686476.7020603@convergence.de>
	 <20040330213418.195dc972.khali@linux-fr.org> <406EBA38.1030203@gmx.de>
	 <20040403163031.122b5df8.khali@linux-fr.org>
Content-Type: text/plain
Message-Id: <1081163597.607.15.camel@newt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 12:13:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-03 at 15:30, Jean Delvare wrote:

> I'm not sure that the function you propose would be really useful. I
> guess that most people don't load i2c chip drivers they don't need. The
> class filter you propose, added to the different I2C addresses, should
> do the rest.

What about using two DVB cards of different models to record off one
multiplex while watching another?

Only an explicit list of which chips should be probed on each I2C bus is
safe for this sort of system.

- Adrian Cox


