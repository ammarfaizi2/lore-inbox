Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUDSI6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 04:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264306AbUDSI6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 04:58:20 -0400
Received: from levante.wiggy.net ([195.85.225.139]:56210 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S264305AbUDSI6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 04:58:14 -0400
Date: Mon, 19 Apr 2004 10:58:10 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] tg3 driver - make use of binary-only firmware optional
Message-ID: <20040419085809.GA585@wiggy.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <20040418135534.GA6142@andaco.de> <20040418180811.0b2e2567.davem@redhat.com> <20040419080439.GB11586@andaco.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419080439.GB11586@andaco.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andreas Jochens wrote:
> Would the patch be acceptable if the firmware parts were kept in tg3.c
> as they are now but #ifdef'd out when CONFIG_TIGON3_FIRMWARE is not set?

Is there any reason for not using the hotplug firmware infrastructure?

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

