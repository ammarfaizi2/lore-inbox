Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270945AbTGPQ0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270948AbTGPQ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:26:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:57525 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270945AbTGPQ0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:26:24 -0400
Date: Wed, 16 Jul 2003 09:37:52 -0700
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] Add a driver for the Technisat Skystar2 DVB card
Message-ID: <20030716163752.GA7604@kroah.com>
References: <1058271657827@convergence.de> <10582716573394@convergence.de> <20030716012841.GA2017@kroah.com> <3F1501B9.8010603@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1501B9.8010603@convergence.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 09:41:45AM +0200, Michael Hunold wrote:
> 
> The DVB core is quite self contained and we decided to copy the i2c 
> functionality needed for our purposes. So we ended up in using about 100 
> lines of code instead of the whole i2c core.
> 
> Now that you have finished improving the i2c core, perhaps we can switch 
> back to the kernel i2c system at a later time.

Please, that would help reduce the number of times the i2c code has been
copied around :)

thanks,

greg k-h
