Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbRFTWoA>; Wed, 20 Jun 2001 18:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbRFTWnl>; Wed, 20 Jun 2001 18:43:41 -0400
Received: from marine.sonic.net ([208.201.224.37]:21628 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S262868AbRFTWnc>;
	Wed, 20 Jun 2001 18:43:32 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 20 Jun 2001 15:43:19 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Why use threads ( was: Alan Cox quote?)
Message-ID: <20010620154319.A15561@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKOENMPPAA.davids@webmaster.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 03:18:58PM -0700, David Schwartz wrote:
> 	As I said, you don't want to use one thread for each client. You use, say,
> 10 threads for the 16,000 clients. That way, if an occasional client
> ambushes a thread (say by reading a file off an NFS server or by using some
> infrequently used code that was swapped to a busy disk), your server will
> keep on humming.


This same approach can easily be used by multiple processes.

I don't see what is gained by using threads over processes for such an
architecture.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
