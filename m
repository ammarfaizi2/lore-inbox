Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVDFO34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVDFO34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 10:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVDFO34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 10:29:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:40909 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262216AbVDFO3t (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 10:29:49 -0400
Date: Wed, 6 Apr 2005 07:25:13 -0700
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Derek Cheung <derek.cheung@sympatico.ca>,
       "'Andrew Morton'" <akpm@osdl.org>, Linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Message-ID: <20050406142513.GB27741@kroah.com>
References: <003901c53a51$0093b7d0$1501a8c0@Mainframe> <42535AF1.5080008@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42535AF1.5080008@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 08:43:45PM -0700, Randy.Dunlap wrote:
> Big Question:  does most Coldfire or I2C use volatile so heavily,
> or is it just this one driver that does that?  Volatile here
> semms very overused.

It's not a i2c issue, volatile should not be needed here at all.

thanks,

greg k-h
