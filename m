Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVGQKVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVGQKVG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 06:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVGQKVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 06:21:06 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:65412 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261235AbVGQKVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 06:21:05 -0400
From: "Nathanael Nerode" <neroden@twcny.rr.com>
Date: Sun, 17 Jul 2005 06:09:40 -0400
To: linux-kernel@vger.kernel.org
Subject: Linus's git tree broken?
Message-ID: <20050717100940.GA22224@twcny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
defaulting to local storage area
06:02:39 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/heads/master [41/41] -> "refs/heads/origin" [1]
progress: 2 objects, 897 bytes
error: File 2a7e338ec2fc6aac461a11fe8049799e65639166 (http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/2a/7e338ec2fc6aac461a11fe8049799e65639166) corrupt

Cannot obtain needed blob 2a7e338ec2fc6aac461a11fe8049799e65639166
while processing commit 0000000000000000000000000000000000000000.
error: cannot map sha1 file 2a7e338ec2fc6aac461a11fe8049799e65639166
cg-pull: objects pull failed
cg-init: pull failed

Sure enough, that blob doesn't exist on the server.
What is going on here?

-- 
Don't say I didn't warn you.
