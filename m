Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265140AbUFATBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbUFATBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUFATBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:01:48 -0400
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:8206 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S265140AbUFATBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:01:45 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: davids@webmaster.com
Subject: Re: why swap at all? (what the user feels)
Date: Tue, 1 Jun 2004 21:01:40 +0200
User-Agent: KMail/1.6.1
Cc: <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKKEGNMFAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEGNMFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406012101.40302.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 June 2004 20.01, David Schwartz wrote:
> >  From what I've read previously in this thread, it seems to me that the
> > only major problem with swapping that not all users want file system
> > cache to swap out actual applications (thus making that somewhat aged
> > mozilla window abit laggy).
> >
> > Maybe we could just have a "Allow file system cache to swap out
> > applications checkbox somewhere"?
> >
> > Or, Am I missing something?
>
> 	In practice, that would make no difference at all. Once physical memory is
> full (and it pretty much will always be so), every memory request (whether

No. 

Many people have machines with plenty of RAM (512MB or more is pretty much 
standard on new machines), much of which is only used to cache files. The 
file cache is the reason the memory is full.

-- robin
