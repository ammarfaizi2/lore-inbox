Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265762AbUADRQA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUADRQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:16:00 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:8401 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265762AbUADRP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:15:59 -0500
Date: Sun, 4 Jan 2004 09:15:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paolo Ornati <ornati@lycos.it>, gandalf@wlug.westbo.se,
       linuxram@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Buffer and Page cache coherent? was: Strange IDE performance change in 2.6.1-rc1 (again)
Message-ID: <20040104171545.GR1882@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Paolo Ornati <ornati@lycos.it>, gandalf@wlug.westbo.se,
	linuxram@us.ibm.com, linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <20040102213228.GH1882@matchmail.com> <1073082842.824.5.camel@tux.rsn.bth.se> <200401031213.01353.ornati@lycos.it> <20040103144003.07cc10d9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103144003.07cc10d9.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 02:40:03PM -0800, Andrew Morton wrote:
> No effort was made to optimise buffered blockdev reads because it is not
> very important and my main interest was in data coherency and filesystem
> metadata consistency.

Does that mean that blockdev reads will populate the pagecache in 2.6?
