Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287120AbRL2EWk>; Fri, 28 Dec 2001 23:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287121AbRL2EWa>; Fri, 28 Dec 2001 23:22:30 -0500
Received: from marine.sonic.net ([208.201.224.37]:13170 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S287120AbRL2EWS>;
	Fri, 28 Dec 2001 23:22:18 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 28 Dec 2001 20:21:39 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system
Message-ID: <20011229042139.GC14067@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011228161603.B5397@havoc.gtf.org> <7850.1009589209@ocs3.intra.ocs.com.au> <20011228225803.A7801@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011228225803.A7801@havoc.gtf.org>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 10:58:03PM -0500, Legacy Fishtank wrote:
> s/break/update dependencies/
> 
> I assumed this was blindingly obvious, but I guess not.

To YOU and other kernel hackers, yes.

But not to everyone.

Plus, as I understand it, it will be faster to:

apply a patch and rebuild with kbuild 2.5

than to:

apply a patch, make dep && make bzImage.

Correct?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
