Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVFNSM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVFNSM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFNSM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:12:58 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:17628 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261276AbVFNSMz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:12:55 -0400
Date: Tue, 14 Jun 2005 11:12:54 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Nikita Danilov <nikita@clusterfs.com>
cc: P@draigBrady.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: optimal file order for reading from disk
In-Reply-To: <m1br6896ss.fsf@clusterfs.com>
Message-ID: <Pine.LNX.4.62.0506141110130.7310@twinlark.arctic.org>
References: <42AEBDC4.2050907@draigBrady.com> <20050614121320.GA4739@outpost.ds9a.nl>
 <42AEE2D5.50902@draigBrady.com> <m1br6896ss.fsf@clusterfs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2005, Nikita Danilov wrote:

> You should call fibmap ioctl on all files, to obtain lists of block
> numbers used by them, and then sort file list to minimize seeks.

hey that's a cool hack...

looking at FIBMAP i see it uses an int to store the block number... any 
plans for a FIBMAP64 api?

-dean
