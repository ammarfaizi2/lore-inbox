Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274844AbRIVAgT>; Fri, 21 Sep 2001 20:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274869AbRIVAgJ>; Fri, 21 Sep 2001 20:36:09 -0400
Received: from marine.sonic.net ([208.201.224.37]:7028 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S274844AbRIVAgH>;
	Fri, 21 Sep 2001 20:36:07 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 21 Sep 2001 17:36:27 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS daemons in D state for 2 minutes at shutdown
Message-ID: <20010921173627.C9110@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15275.51188.271719.562445@charged.uio.no>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 01:06:28AM +0200, Trond Myklebust wrote:
> Use a combination of 'ps' and 'kill -9' or even 'killall'. Anything
> that actually selects the nfsd daemons and *NOT* the portmapper.


Personally I'd suggest NOT getting into the habit of using killall.  It
performs like killall5 does on SysV machines.  So if you forget which
machine you're on....

My personal favorite for years was /bin/kill <process name>.  However, it
depends on which package your system actually uses for /bin/kill (the kill
from util-linux can kill by name, the procps one can not).

Lately I've been trying to train myself into using skill (from procps).

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
