Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135206AbREFIgk>; Sun, 6 May 2001 04:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135216AbREFIgV>; Sun, 6 May 2001 04:36:21 -0400
Received: from marine.sonic.net ([208.201.224.37]:50792 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S135206AbREFIgJ>;
	Sun, 6 May 2001 04:36:09 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sun, 6 May 2001 01:36:05 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4 add suffix for uname -r
Message-ID: <20010506013605.C31385@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105060334390.1549-100000@asdf.capslock.lan> <3437.989135106@ocs3.ocs-net> <20010506101217.H3988@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <20010506101217.H3988@marowsky-bree.de>; from lmb@suse.de on Sun, May 06, 2001 at 10:12:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 10:12:17AM +0200, Lars Marowsky-Bree wrote:
> You assign a new EXTRAVERSION to the new kernel you are building, and keep the
> old kernel at the old name.

Except that some patches (ie, RAID, -ac) use EXTRAVERSION.  There needs to
be a new variable, say USERVERSION, that will *ONLY* be set during make
USERVERSION=foo.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
