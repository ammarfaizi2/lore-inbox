Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUADLL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 06:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUADLL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 06:11:57 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:9661 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265376AbUADLL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 06:11:56 -0500
Date: Sun, 4 Jan 2004 03:11:54 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Does CONFIG_NET_FASTROUTE conflict with CONFIG_NETFILTER?
Message-ID: <20040104111154.GN1882@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If they do, then the config system should not allow you to enable both at
the same time.

Will CONFIG_NET_FASTROUTE speed up bridging?  It config help mentions
nic<->nic transfers...
