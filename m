Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbTAKFcF>; Sat, 11 Jan 2003 00:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267090AbTAKFcF>; Sat, 11 Jan 2003 00:32:05 -0500
Received: from cust.7.144.adsl.cistron.nl ([62.216.7.144]:60682 "EHLO sawmill")
	by vger.kernel.org with ESMTP id <S267084AbTAKFcD>;
	Sat, 11 Jan 2003 00:32:03 -0500
Date: Sat, 11 Jan 2003 06:40:49 +0100
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch] net/irda compile warnings in 2.4.21-pre3
Message-ID: <20030111054049.GA27104@sawmill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: kernel@mail.vroon.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have fixed the compile warnings in net/irda that happened because of 
GCC's deprication of the concentenation of string literals with 
__FUNCTION__.
Tested on my tree. This my first patch, if it's not in optimal format, I 
apologize.

The patch is at 
http://www.chainsaw.cistron.nl/compile-fixes-irda.patch.gz

It should apply cleanly to vanilla 2.4.21-pre3 sources.


Tony.
