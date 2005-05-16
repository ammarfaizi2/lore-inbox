Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVEPFMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVEPFMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 01:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVEPFMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 01:12:52 -0400
Received: from stark.xeocode.com ([216.58.44.227]:9924 "EHLO stark.xeocode.com")
	by vger.kernel.org with ESMTP id S261331AbVEPFMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 01:12:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Problem report: 2.6.12-rc4 ps2 keyboard being misdetected as /dev/input/mouse0
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 16 May 2005 01:12:41 -0400
Message-ID: <87zmuveoty.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just updated to 2.6.12-rc4 and now /dev/input/mouse0 seems to be my ps2
keyboard. My ps2 mouse is now on /dev/input/mouse1.


Good thing to catch before you release 2.6.12 and get the usual swarm of "my
mouse stopped working" reports. It seems to be getting to be a pattern:
upgrade linux kernel -- debug why mouse stopped working.

-- 
greg

