Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVCJJvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVCJJvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVCJJvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:51:55 -0500
Received: from aun.it.uu.se ([130.238.12.36]:1698 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262483AbVCJJvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:51:54 -0500
Date: Thu, 10 Mar 2005 10:51:46 +0100 (MET)
Message-Id: <200503100951.j2A9pkR6001632@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, mikael.starvik@axis.com
Subject: RE: [PATCH][2.4.30-pre1] preliminary fixes for gcc-4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 09:50:11 +0100, Mikael Starvik wrote:
>>+#if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR >= 96)
>
>Should be __GNUC_MINOR__

Thanks, I'll fix that.

/Mikael
