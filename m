Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316780AbSGBNVr>; Tue, 2 Jul 2002 09:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316783AbSGBNVq>; Tue, 2 Jul 2002 09:21:46 -0400
Received: from pc-62-30-72-191-ed.blueyonder.co.uk ([62.30.72.191]:10625 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316780AbSGBNVp>; Tue, 2 Jul 2002 09:21:45 -0400
Date: Tue, 2 Jul 2002 14:23:31 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Stephen Tweedie <sct@redhat.com>, Miles Lane <miles@megapathdsl.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020702142331.D2877@redhat.com>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au> <20020626011340.A13410@redhat.com> <3D1A0A63.BB5F0C33@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D1A0A63.BB5F0C33@zip.com.au>; from akpm@zip.com.au on Wed, Jun 26, 2002 at 11:39:31AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 26, 2002 at 11:39:31AM -0700, Andrew Morton wrote:

> Yes, that would be better.  We do want to be able to change it
> on the fly.  So how about:
> 
> 	mount /dev/what /mnt/where -o commit_interval=5
> and
> 	mount /mnt/where -o remount,commit_interval=3000

I just implemented that on the way back from OLS, will check it in
shortly.

--Stephen
