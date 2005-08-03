Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVHCV4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVHCV4K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVHCV4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:56:10 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:31514 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261557AbVHCV4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:56:08 -0400
Date: Wed, 3 Aug 2005 14:55:59 -0700
From: Mike Waychison <mikew@google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Conversion of /proc/sysvipc/* to seq_file
Message-ID: <20050803215559.GA3303@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patches convert /proc/sysvipc/* to use seq_file.

This gives us the following:

 - Self-consistent IPC records in proc.
 - O(n) reading of the files themselves.

Please consider applying.  Thanks,

Mike Waychison
