Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUCODlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 22:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbUCODlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 22:41:45 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:64429 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S262226AbUCODln
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 22:41:43 -0500
Date: Mon, 15 Mar 2004 04:41:25 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: jpearson@oasissystems.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange ext3 corruption problem on 2.6.x
Message-ID: <20040315034125.GA5295@schmorp.de>
Mail-Followup-To: jpearson@oasissystems.com.au,
	linux-kernel@vger.kernel.org
References: <20040314222929.GA23106@mark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314222929.GA23106@mark>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 08:59:29AM +1030, jpearson@oasissystems.com.au wrote:
> 'r/o' by the RAID layer, presumably unbeknownst to VFS; are you
> *sure* that your array is still up and 'good' when you get this
> message?

As I said, there are no other messages, so if there is a problem (cabling,
disk-i/o etc.), then the kernel doesn't know it either (usually the kernel
it quite loud in this condition).

The array also comes up clean and synced. And the reiserfs partition on
the same lv doesn't have any problems (wether this means that reiserfs
doesn't suffer from this bug or wether reiserfs is just unable to detect
it is, of course, a different question).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
