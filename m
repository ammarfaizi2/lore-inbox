Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbTEYU1Q (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbTEYU1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:27:16 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:42758
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263746AbTEYU1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:27:12 -0400
Date: Sun, 25 May 2003 13:37:09 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
   lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030525203709.GA23651@matchmail.com>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva> <20030525173642.GA1365@alpha.home.local> <20030525170046.GA649@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525170046.GA649@alpha.home.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 07:00:46PM +0200, Willy Tarreau wrote:
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }

Can you revert back to your previous kernel and run badblocks read-only on
it a few times.  Your drive may be going bad.
