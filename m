Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282285AbRKWXbY>; Fri, 23 Nov 2001 18:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282283AbRKWXbE>; Fri, 23 Nov 2001 18:31:04 -0500
Received: from marine.sonic.net ([208.201.224.37]:4197 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S282285AbRKWXbA>;
	Fri, 23 Nov 2001 18:31:00 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 23 Nov 2001 15:30:56 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2fsck-1.25 problem
Message-ID: <20011123153056.A24052@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BFDBB15.AD778DA4@isn.net> <20011122211827.T1308@lynx.no> <3BFE099F.52BB7006@isn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BFE099F.52BB7006@isn.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 04:32:31AM -0400, Garst R. Reese wrote:
> The problem is solved. fsck was dependent on libgcc_s.so.1, which had no
> execute permissions. Don't know how that happened. It was also on
> /usr/local/lib on another partition and I moved it to /lib

Recently installed gcc-3.0.x, I take it?

This was a move I recently regretted, because of this issue.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
