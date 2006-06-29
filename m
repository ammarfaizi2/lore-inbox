Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWF2BFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWF2BFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 21:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWF2BFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 21:05:32 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:38337 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751850AbWF2BFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 21:05:32 -0400
Message-ID: <44A3277B.9060009@acm.org>
Date: Wed, 28 Jun 2006 20:06:03 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: "amatus@ocgnet.org" <amatus@ocgnet.org>
CC: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI: Support registering for a command per-channel
References: <20060623150705.GA14245@login.ocgnet.org> <449FF130.3010601@acm.org> <20060628192805.GA32766@login.ocgnet.org>
In-Reply-To: <20060628192805.GA32766@login.ocgnet.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch looks good to me.  I added the following as a header.
Is this ok?  The "Signed-off-by" line is pretty important in patches.

Thanks,

-Corey
--

This patch adds the ability to register for a command per-channel in
the IPMI driver.

If your BMC supports multiple channels, incoming messages can be
differentiated by the channel on which they arrived. In this case it's
useful to have the ability to register to receive commands on a
specific channel instead the current behaviour of all channels.

Signed-off-by: David Barksdale <amatus@ocgnet.org>

