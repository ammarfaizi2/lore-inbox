Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUC2ENJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUC2ENJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:13:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:11139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262605AbUC2ENH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:13:07 -0500
Date: Sun, 28 Mar 2004 20:12:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: "John Stoffel" <stoffel@lucent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm1 - swapoff dies with OOM, why?
Message-Id: <20040328201259.1c8ee95c.akpm@osdl.org>
In-Reply-To: <16487.35872.160526.477780@gargle.gargle.HOWL>
References: <16487.35872.160526.477780@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Stoffel" <stoffel@lucent.com> wrote:
>
>  I've run into a strange situation here.  I was having *terrible*
>  performance while doing a complile of the 2.6.5-rc2-mm2 kernel

Were you using rc2-mm1 at the time?  It had a memory leak in ext3.  Lots of
memroy was leaked, so swapoff cannot get sufficient memory to do its thing.

