Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262007AbSIYPjE>; Wed, 25 Sep 2002 11:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262008AbSIYPjE>; Wed, 25 Sep 2002 11:39:04 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:28936 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262007AbSIYPjD>;
	Wed, 25 Sep 2002 11:39:03 -0400
Date: Wed, 25 Sep 2002 08:43:00 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: gerg@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.5.38uc1 (MMU-less support)
Message-ID: <20020925154300.GF30339@kroah.com>
References: <20020925151943.B25721@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020925151943.B25721@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 03:19:43PM +0100, Matthew Wilcox wrote:
> * You're defining CONFIG_* variables in the .c file.  I don't know whether
>   this is something we're still trying to avoid doing ... Greg, you seem
>   to be CodingStyle enforcer, what's the word?

I haven't seen that used very much, but I would not recommend it.  Why
not just move it to the Config.in file?  And if they are always set,
just remove them.

