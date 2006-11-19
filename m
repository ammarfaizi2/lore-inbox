Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933529AbWKSWek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933529AbWKSWek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 17:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933565AbWKSWek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 17:34:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:50676 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933529AbWKSWej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 17:34:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:mime-version:content-type:content-transfer-encoding;
        b=JT3mHgMRJHEXwhefrUN+SUA/ygSapkcFecndgqnCoAksyPOwR1/+mu/qko/42ukwPXLMtWVRLgMhkggDnMZFFFa+nhjxWmxL2tNAnRK03KsIxUwakJZ+0fw++YmVw/mWdv+y3IDB/mDzh4h+OUvq8lvM0QHWiX+yTbS7yqCPr+o=
Date: Mon, 20 Nov 2006 00:34:37 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <1154868495.20061120003437@gmail.com>
To: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
CC: kernel-discuss@handhelds.org
Subject: Where did find_bus() go in 2.6.18?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

  We here at Handhelds.org upgrading our drivers to 2.6.18 and I just
caught a case of find_bus() being undefined during link. Quickly
traced this to
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7e4ef085ea4b00cfc34e854edf448c729de8a0a5

  But alas, the commit message is not as good as some others are, and
doesn't mention what should be used instead. So, if find_bus() is
"unused", what should be used instead?


Thank you,

-- 
 Paul                          mailto:pmiscml@gmail.com

