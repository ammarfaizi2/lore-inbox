Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVKHUSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVKHUSs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVKHUSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:18:48 -0500
Received: from web34112.mail.mud.yahoo.com ([66.163.178.110]:61581 "HELO
	web34112.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030256AbVKHUSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:18:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Tj7m8GDB5GK/rPtHCMvZtmGzoHj9FZfhRaIaB2RTzeGoBw618AKWbhr80icQ7YLuuHmsYAhzJow4jLD6Q1b4zpuVcMLL7nrhHf3jS2QPeKHVPCF6tibeXH1wH95KxOMokav3n/pbAoEQTJOqfAfus7obJaRb0aa2jdm9exdAaew=  ;
Message-ID: <20051108201847.89115.qmail@web34112.mail.mud.yahoo.com>
Date: Tue, 8 Nov 2005 12:18:47 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131480107.32482.48.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I knew I forgoet something important in the info:
  type nfs (rw,tcp,rsize=32768,wsize=32768,hard,intr,vers=3,tcp,rsize=32768,wsize=32768,hard,intr

-Kenny


--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Tue, 2005-11-08 at 11:25 -0800, Kenny Simpson wrote:
> > Just another data point....
> > If I open the file with O_DIRECT.. not much changes:
> 
> Hmm... Are you mounting using the -osync or -onoac options? Doing
> synchronous writes will tend to slow down flushing considerably, and the
> VM appears to be very fragile w.r.t. slow filesystems.
> 
> Cheers,
>   Trond



		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
