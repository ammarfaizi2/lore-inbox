Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbRGJABj>; Mon, 9 Jul 2001 20:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265128AbRGJABa>; Mon, 9 Jul 2001 20:01:30 -0400
Received: from marine.sonic.net ([208.201.224.37]:39779 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S265101AbRGJABQ>;
	Mon, 9 Jul 2001 20:01:16 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Mon, 9 Jul 2001 17:01:15 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Regarding the make module_install.
Message-ID: <20010709170114.A5912@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010709234259.42707.qmail@web14903.mail.yahoo.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 04:42:59PM -0700, sendhil kumar wrote:
> Can any one update me about, what make module and make

make modules compiles and links the modules

> module_install do? What is the difference between the 

module_install places them in /lib/modules/`uname -a`/*

> insmod command and module_install?

insmod first looks in /lib/modules/`uname -a`/* to load the module into
kernel space.

[certain details may be incorrect, but that the general idea.]

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
