Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbTD1SM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbTD1SM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:12:58 -0400
Received: from hypatia.llnl.gov ([134.9.11.73]:25496 "EHLO hypatia.llnl.gov")
	by vger.kernel.org with ESMTP id S261235AbTD1SM5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:12:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Peterson <dsp@llnl.gov>
Organization: Lawrence Livermore National Laboratory
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 patch to fix race condition in iput()
Date: Mon, 28 Apr 2003 11:25:05 -0700
User-Agent: KMail/1.4.1
Cc: viro@parcelfarce.linux.theplanet.co.uk
References: <200304281048.39478.dsp@llnl.gov>
In-Reply-To: <200304281048.39478.dsp@llnl.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304281125.05886.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 April 2003 10:48 am, I wrote:
>     ...
>
>     add the inode to nodes_in_use, and then release inode_lock and
>
>     ...
>
>     nodes_in_use list, and destroy the inode.

 Oops... I meant to say "inode_in_use".

-Dave
