Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264817AbRFSWn0>; Tue, 19 Jun 2001 18:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264819AbRFSWnQ>; Tue, 19 Jun 2001 18:43:16 -0400
Received: from marine.sonic.net ([208.201.224.37]:12894 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S264817AbRFSWnE>;
	Tue, 19 Jun 2001 18:43:04 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 19 Jun 2001 15:42:51 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
Message-ID: <20010619154251.G6778@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B2FC7F4.2AAA6A8D@inet.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 04:45:24PM -0500, Eli Carter wrote:
> Gabriel Rocha wrote:
> > you could always compile on one machine and nfs mount the /usr/src/linux
> > and do a make modules_install from the nfs mounted directory...
> 
> Which would require exporting that filesystem with root permissions
> enabled...any security bells going off?

Why would you need to have nfs root access?

You're reading from the nfs mount, not writing to it.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
