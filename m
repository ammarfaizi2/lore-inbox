Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbUK1QrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUK1QrF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbUK1Qpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:45:36 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:12051 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261518AbUK1QkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:40:19 -0500
Date: Wed, 17 Nov 2004 20:21:59 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.10-rc2] 3c59x: reload EEPROM values at rmmod for needy cards
Message-ID: <20041118012155.GA22765@tuxdriver.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
References: <20041117160122.A4824@tuxdriver.com> <20041117134425.62034944.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117134425.62034944.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:44:25PM -0800, Andrew Morton wrote:
> "John W. Linville" <linville@tuxdriver.com> wrote:
> >
> > 3c905 cards need an additional bit unmasked in the reset at rmmod or
> > else they don't get reinitialized properly when the driver is reloaded.
> 
> This has been in -mm kernels since you first sent it out.  I'm intending to
> hold off until post-2.6.10 so we get a full kernel cycle for any problems
> to get shaken out.

Cool...someone was asking for it in netdev-2.[46], and Jeff didn't
have it.  That is what provoked the resend.

Thanks for the update!

John
-- 
John W. Linville
linville@tuxdriver.com
