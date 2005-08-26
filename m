Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVHZGAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVHZGAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 02:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVHZGAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 02:00:34 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:3544 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S932180AbVHZGAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 02:00:33 -0400
Date: Fri, 26 Aug 2005 06:09:28 +0000
From: Kent Robotti <dwilson24@nyc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Initramfs and TMPFS!
Message-ID: <20050826060928.GA1009@Linux.nyc.rr.com>
Reply-To: dwilson24@nyc.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   >I'm not subscribed, so sorry if this doesn't fall into the original
   >thread. I'm curious as to why the kernel has to include the decoder -
   >why you can't just run a self-extracting executable in an empty
   >initramfs (with a preset capacity if needs be).

The kernel already includes gunzip for itself, so it just needs an
unarchiver (tar or cpio) which should just add a few Kb.

Every self-extracting executable would require the builtin code
to extract itself.

The kernel code to recognize and execute the self-extracting code,
would probably be the same size as an unarchiver (tar or cpio).

