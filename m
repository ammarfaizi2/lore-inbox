Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUA2FkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 00:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUA2FkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 00:40:12 -0500
Received: from sputnik.senv.net ([213.157.66.5]:2820 "EHLO sputnik.senv.net")
	by vger.kernel.org with ESMTP id S261957AbUA2FkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 00:40:10 -0500
Date: Thu, 29 Jan 2004 07:40:07 +0200 (EET)
From: Jussi Hamalainen <count@theblah.fi>
X-X-Sender: count@mir.senv.net
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS: giant filename in readdir
In-Reply-To: <1075331193.1616.69.camel@nidelv.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0401290736210.12477@mir.senv.net>
References: <Pine.LNX.4.58.0401272233490.10626@mir.senv.net>
 <1075331193.1616.69.camel@nidelv.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004, Trond Myklebust wrote:

> Any info forthcoming on the filesystem you used and/or a binary tcpdump
> demonstrating the problem?

All filesystems are ext3. I'll try to get you a tcpdump if and when
the phenomenon happens again.

> Does the problem still occur when you change "soft" to "hard"?

Both boxes have two NFS-mounts from each other. One is soft, one is
hard and this happens on both mounts simultaineously.

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.fi ]=-
