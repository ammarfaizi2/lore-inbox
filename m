Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVGLXI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVGLXI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbVGLXGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:06:23 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:29347 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262483AbVGLXFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:05:44 -0400
Date: Tue, 12 Jul 2005 17:05:39 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: [2.6 patch] fs/jbd/: possible cleanups
Message-ID: <20050712230539.GX5335@schatzie.adilger.int>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, sct@redhat.com,
	linux-kernel@vger.kernel.org, ext3-users@redhat.com
References: <20050712202742.GM4034@stusta.de> <20050712223243.GW5335@schatzie.adilger.int> <20050712224353.GN4034@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712224353.GN4034@stusta.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 13, 2005  00:43 +0200, Adrian Bunk wrote:
> On Tue, Jul 12, 2005 at 04:32:44PM -0600, Andreas Dilger wrote:
> > I don't mind removing this function, but it shouldn't be put inside #ifdef
> > JBD_DEBUG, as that would remove the check from the compiler-parsed code
> > and defeat the purpose of the check.
> 
> That's not what my patch is doing.
> 
> journal_init() is not inside an #ifdef JBD_DEBUG.

My bad.  You didn't generate diff with -p (which I normally do and is
incredibly useful when reviewing patches) and I saw "write_jbd_debug()"
above and my brain went on autopilot assuming the code had moved into
that function.  Objection withdrawn.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

