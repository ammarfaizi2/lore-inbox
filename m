Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264146AbRFNXBU>; Thu, 14 Jun 2001 19:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264157AbRFNXBK>; Thu, 14 Jun 2001 19:01:10 -0400
Received: from marine.sonic.net ([208.201.224.37]:7026 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S264146AbRFNXAz>;
	Thu, 14 Jun 2001 19:00:55 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 14 Jun 2001 16:00:43 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: threading question (results after thread pooling)
Message-ID: <20010614160043.G26165@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0106141632200.3287-100000@gene.pbi.nrc.ca>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 04:42:29PM -0600, ognen@gene.pbi.nrc.ca wrote:
> 2. The main thread sets up the data (which are global) and then signals
> that there is work to be done on the same condition variable. The first
> thread to get awaken takes the work. the remaining threads keep waiting.

For curiosities sake, at what point would this technique result in a
thundering herd issue?  Does it happen near the level at which the number of
schedulable entities equal the number of processors or does it have to be
much greater than that?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
