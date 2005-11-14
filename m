Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVKNTii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVKNTii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVKNTif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:38:35 -0500
Received: from 81-178-76-253.dsl.pipex.com ([81.178.76.253]:65187 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751258AbVKNTiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:38:17 -0500
Date: Mon, 14 Nov 2005 19:37:36 +0000
To: akpm@osdl.org
Cc: apw@shadowen.org, kravetz@us.ibm.com, haveblue@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Squash hotplug warnings
Message-ID: <exportbomb.1131997056@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following this mail are 4 small patches cleaning up some Warnings
introduced in the merge of the hotplug code:

	__add_section remove unused pgdat definition
	register_ and unregister_memory_notifier should be global
	register_memory should be global
	memory_hotplug_name should be const

These are against 2.6.14-mm2.  Please consider for -mm.

-apw
