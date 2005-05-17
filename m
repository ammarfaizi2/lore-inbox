Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVEQOs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVEQOs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 10:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVEQOs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 10:48:56 -0400
Received: from [81.2.110.250] ([81.2.110.250]:46054 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261553AbVEQOsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 10:48:54 -0400
Subject: Re: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain>
References: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116341217.21388.145.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 May 2005 15:47:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-05-14 at 14:18, Justin Piszcz wrote:
> The mount options I am using are:
> rw,hard,intr,rsize=65536,wsize=65536,nfsvers=3 0 0

These are rather extreme r/wsizes especially if you are using UDP - I'm
assuming this is TCP ?

> Oh, and incase one may think there is a network issue, there is not, 
> during normal operation when I am not running dd, there are no network 
> problems, as shown below.

I would certainly expect it to be a memory issue. Does it occur with
8192 as the size ?

