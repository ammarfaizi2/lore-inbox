Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135663AbRDSNXq>; Thu, 19 Apr 2001 09:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135664AbRDSNXh>; Thu, 19 Apr 2001 09:23:37 -0400
Received: from marine.sonic.net ([208.201.224.37]:873 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S135663AbRDSNXW>;
	Thu, 19 Apr 2001 09:23:22 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 19 Apr 2001 06:23:18 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cross-referencing frenzy
Message-ID: <20010419062318.F21159@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010418233445.A28628@thyrsus.com> <200104190449.f3J4n2LF032522@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <200104190449.f3J4n2LF032522@webber.adilger.int>; from adilger@turbolinux.com on Wed, Apr 18, 2001 at 10:49:01PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 10:49:01PM -0600, Andreas Dilger wrote:
> However, I'm not sure that your reasoning for removing these is correct.
> For example, one symbol that I saw was CONFIG_EXT2_CHECK, which is code
> that used to be enabled in the kernel, but is currently #ifdef'd out with
> the above symbol.  When Ted changed this, he wasn't sure whether we would

How about something besides CONFIG_ then?  Like maybe DEV_CONFIG_ or DEV_.

The CONFIG_ name space should be reserved for things that can be configured
via the config mechanism.

Things that only developers or special testers might want should use
something other than the CONFIG_ namespace.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
