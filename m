Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310175AbSCKQCr>; Mon, 11 Mar 2002 11:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310176AbSCKQCh>; Mon, 11 Mar 2002 11:02:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51474 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S310175AbSCKQC1>; Mon, 11 Mar 2002 11:02:27 -0500
Date: Mon, 11 Mar 2002 17:02:25 +0100
From: Jan Kara <jack@ucw.cz>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] Networking compile problem in 2.5.6
Message-ID: <20020311160225.GA27223@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I found a compilation problem in 2.5.6: when disabling TCP in
config (CONFIG_INET not set). Then tcp.h is not included in
linux/net/core/sock.c and symbols like TCP_CLOSE are missing...

							Honza
