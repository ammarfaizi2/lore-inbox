Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280400AbRJaSjw>; Wed, 31 Oct 2001 13:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280403AbRJaSjc>; Wed, 31 Oct 2001 13:39:32 -0500
Received: from marine.sonic.net ([208.201.224.37]:8553 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S280400AbRJaSj0>;
	Wed, 31 Oct 2001 13:39:26 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 31 Oct 2001 10:40:00 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: cdrecord from ext3
Message-ID: <20011031104000.D1767@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011031001846.A1840@werewolf.able.es> <3BDF576F.3A797933@zip.com.au> <20011031155934.A18608@werewolf.able.es> <9rpdp8$601$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9rpdp8$601$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 09:52:40AM -0800, H. Peter Anvin wrote:
> By author:    "J . A . Magallon" <jamagallon@able.es>
> > Did you noticed that the ext3 was at 20MHz, and ext2 was at 40MHz ? I
> > will reformat the 20MHz drive and make 2 slices, one ext2 and one ext3
> > to be sure not to compare apples and oranges...
> 
> Doesn't work.  Low block numbers (outer edge of the disk) is
> invariably faster than high block numbers (inner edge of the disk) on
> all drives that are even close to recent.

So unmount and remount as ext2?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
