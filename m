Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbUKYBbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUKYBbh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbUKYBbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:31:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:9889 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262886AbUKYBb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:31:27 -0500
Date: Wed, 24 Nov 2004 17:18:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: pawfen@wp.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: MTRR vesafb and wrong X performance
Message-Id: <20041124171805.0586a5a1.akpm@osdl.org>
In-Reply-To: <1101338139.1780.9.camel@PC3.dom.pl>
References: <1101338139.1780.9.camel@PC3.dom.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Fengler <pawfen@wp.pl> wrote:
>
> When I use boot option "video=vesafb:nomtrr" with any 2.6.x kernel,
>  Xserver performance is nearly as good as under 2.4.x kernel
>  and warning (in xorg.log) does not appear.
> 
>  It seems to be a problem with mtrr and vesafb described several times,
>  for example Jan 18, 2004 in thread "Overlapping MTRRs in 2.6.1"
>  but it was a long time ago.

Please send the full dmesg output and the contents of /proc/mtrr for
2.6.10-rc2.
