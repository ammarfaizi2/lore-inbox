Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVCXLh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVCXLh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVCXLh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:37:28 -0500
Received: from skora.net ([62.141.41.44]:33413 "EHLO skora.net")
	by vger.kernel.org with ESMTP id S262448AbVCXLhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:37:24 -0500
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] via-rhine.c, wol-bugfix, Kernel 2.6.11.5
References: <87psxp6fq4.fsf@powers.localnet>
	<20050324074109.GA14926@k3.hellgate.ch>
From: Thomas Skora <thomas@skora.net>
Date: Thu, 24 Mar 2005 12:37:50 +0100
In-Reply-To: <20050324074109.GA14926@k3.hellgate.ch> (Roger Luethi's message
 of "Thu, 24 Mar 2005 08:41:09 +0100")
Message-ID: <87br9946lt.fsf@powers.localnet>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi <rl@hellgate.ch> writes:

> This patch won't apply to the 2.6.11.5 I have here -- the driver is
> clearing ~0xFC already. The description makes me suspect that the patch
> is meant to go the other way, and that would be wrong.

You are right. I don't know what happened, but in my sources (from
kernel.org without any patches) this was cleared to 0xFE.

> Use ethtool if you want to enable WOL, default in Linux net drivers is
> off.

The problem was, that this doesn't worked.

> Please don't send patches as application/octet-stream, that's
> annoying. Send either text/plain or inline.

Ok, thank you for the hint.

Thomas
