Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270553AbTGNHBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270551AbTGNHBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:01:42 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:57355 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S270553AbTGNHBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:01:41 -0400
Date: Mon, 14 Jul 2003 09:16:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/fs/file-max broken in 2.4.22-pre5
Message-ID: <20030714071621.GA643@alpha.home.local>
References: <200307132231.h6DMVs916407@athlon.cichlid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307132231.h6DMVs916407@athlon.cichlid.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 03:31:54PM -0700, Andrew Burgess wrote:
 
> root@athlon:/root # echo 60000 > /proc/sys/fs/file-max
> root@athlon:/root # cc file-max.c 
> root@athlon:/root # a.out
> Too many open files
> opened 1021 files
> root@athlon:/root # uname -a
> Linux athlon 2.4.22-pre5 #2 SMP Sun Jul 13 12:38:04 PDT 2003 i686 unknown

ulimit -n ?

Willy

