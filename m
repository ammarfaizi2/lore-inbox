Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSL1P1D>; Sat, 28 Dec 2002 10:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSL1P1D>; Sat, 28 Dec 2002 10:27:03 -0500
Received: from [195.20.32.236] ([195.20.32.236]:40110 "HELO euro.verza.com")
	by vger.kernel.org with SMTP id <S262394AbSL1P1C>;
	Sat, 28 Dec 2002 10:27:02 -0500
Date: Sat, 28 Dec 2002 16:30:09 +0100
From: Alexander Kellett <lypanov@kde.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       william stinson <wstinson@wanadoo.fr>, trivial@rustcorp.com.au
Subject: Re: [PATCH] Mark deprecated functions so they give a warning on use
Message-ID: <20021228153009.GA29614@groucho.verza.com>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	william stinson <wstinson@wanadoo.fr>, trivial@rustcorp.com.au
References: <20021228035319.903502C04B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021228035319.903502C04B@lists.samba.org>
User-Agent: Mutt/1.4i
X-Disclaimer: My opinions do not necessarily represent those of my employer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 11:57:10AM +1100, Rusty Russell wrote:
> If anyone can think of a better way, please share.  This should speed
> up the removal of functions like check_region() (which, despite
> William's janitorial efforts, is still not at the stage where it can
> be removed).

can gcc 3.2's __attribute__((deprecated)) be used?

(someone noted this on kde lists a few days back)

Alex
