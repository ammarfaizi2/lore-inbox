Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbRFSVFa>; Tue, 19 Jun 2001 17:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264786AbRFSVFK>; Tue, 19 Jun 2001 17:05:10 -0400
Received: from ohiper1-219.apex.net ([209.250.47.234]:11533 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S264785AbRFSVFF>; Tue, 19 Jun 2001 17:05:05 -0400
Date: Tue, 19 Jun 2001 16:04:56 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Tom Diehl <tdiehl@pil.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
Message-ID: <20010619160456.A28721@hapablap.dyn.dhs.org>
In-Reply-To: <E15CSDK-0006ee-00@the-village.bc.nu> <Pine.LNX.4.33.0106191646330.17727-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106191646330.17727-100000@localhost.localdomain>; from tdiehl@pil.net on Tue, Jun 19, 2001 at 04:55:10PM -0400
X-Uptime: 4:03pm  up 2 days, 22:29,  0 users,  load average: 1.19, 1.23, 1.26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 04:55:10PM -0400, Tom Diehl wrote:
> What is the best way to install the modules? Is there a directory _all_ of
> the modules exist in b4 you do "make modules_install". I usually end up
> setting EXTRAVERSION to something unique and doing a make modules_install.
> That way it does not hose up the modules for the build machine.
> Is there a better way?

Not anymore there isn't.  You'll just have to run make modules_install
as 'INSTALL_MOD_DIR="/path/to/module" make modules_install'
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
