Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbULIX0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbULIX0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbULIX0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:26:04 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:23267 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261677AbULIXZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:25:58 -0500
Date: Thu, 9 Dec 2004 15:17:44 -0800
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: sensors@Stimpy.netroedge.com, Deepak Saxena <dsaxena@plexity.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: checksum in (i2c) eeprom driver
Message-ID: <20041209231744.GA6446@kroah.com>
References: <41B85D43.8070409@verizon.net> <vojkqBdx.1102603548.0379010.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vojkqBdx.1102603548.0379010.khali@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 03:45:48PM +0100, Jean Delvare wrote:
> 
> If the checksumming was that important, I guess it would have been the
> default, which it was not. If it is there for the sole purpose of
> allowing the user to prevent the eeprom driver from taking over
> non-eeprom chips, then the "ignore" module parameter can be used to
> achieve the same effect, faster, plus it is configurable on a
> per-address basis, while the checksum parameter isn't.

I agree, what's wrong with using the ignore stuff instead?

thanks,

greg k-h
