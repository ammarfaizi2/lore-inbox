Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWFTIjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWFTIjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWFTIjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:39:21 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:46213 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S965039AbWFTIjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:39:20 -0400
From: Duncan Sands <baldrick@free.fr>
To: "Avuton Olrich" <avuton@gmail.com>
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Date: Tue, 20 Jun 2006 10:39:17 +0200
User-Agent: KMail/1.9.1
Cc: "Nathan Scott" <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com> <20060620165209.C1080488@wobbly.melbourne.sgi.com> <3aa654a40606200120v5baf0304ka205f1ad8f136ad9@mail.gmail.com>
In-Reply-To: <3aa654a40606200120v5baf0304ka205f1ad8f136ad9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201039.18124.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fatal error -- can't read block 16777216 for directory inode 1507133580

This looks to be the same problem as http://oss.sgi.com/bugzilla/show_bug.cgi?id=631
Note that the block numbers are identical in both reports: 16777216 = 0x1000000.
A very suspicious block number, wouldn't you say?

Best wishes,

Duncan.
