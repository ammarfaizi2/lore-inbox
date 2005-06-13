Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVFMMD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVFMMD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVFMMD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:03:26 -0400
Received: from gs.bofh.at ([193.154.150.68]:20176 "EHLO gs.bofh.at")
	by vger.kernel.org with ESMTP id S261474AbVFMMDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:03:23 -0400
Subject: Re: udp.c
From: Bernd Petrovitsch <bernd@firmix.at>
To: Rommer <rommer@active.by>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42AD74A3.1050006@active.by>
References: <42AD74A3.1050006@active.by>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 13 Jun 2005 14:03:00 +0200
Message-Id: <1118664180.898.13.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 14:57 +0300, Rommer wrote:
> Where used strange function udp_v4_hash?
> linux-2.6.11.11, net/ipv4/udp.c:204
> 
> static void udp_v4_hash(struct sock *sk)

Since it is "static" the user must be in the same source file (or -
theoretically - any included header).
So just use the "find" function of your $PREFERRED_EDITOR.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

