Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271691AbRH1VwD>; Tue, 28 Aug 2001 17:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271142AbRH1Vvw>; Tue, 28 Aug 2001 17:51:52 -0400
Received: from buzz.sonic.net ([208.201.224.78]:30840 "EHLO buzz.sonic.net")
	by vger.kernel.org with ESMTP id <S271367AbRH1Vvg>;
	Tue, 28 Aug 2001 17:51:36 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 28 Aug 2001 14:51:52 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010828145151.C19067@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B8BC94F.207E86EA@linux-m68k.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 06:39:43PM +0200, Roman Zippel wrote:
> Let's assume it does. Joe Hacker uses the new min macro and uses int
> because this_residual is an int. Later he realizes that this_residual
> must be an unsigned int. Will he now also automatically change the type
> in the min macro?


min (typeof(this_residual), this_residual, foo);

Though I'm not sure this would be accepted into the kernel.  :->

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
