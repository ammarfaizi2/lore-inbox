Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135303AbQL3SXy>; Sat, 30 Dec 2000 13:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135301AbQL3SXm>; Sat, 30 Dec 2000 13:23:42 -0500
Received: from p3EE3C958.dip.t-dialin.net ([62.227.201.88]:11524 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135300AbQL3SX3>; Sat, 30 Dec 2000 13:23:29 -0500
Date: Sat, 30 Dec 2000 18:21:54 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: SYN_SENT block
Message-ID: <20001230182154.A1950@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20001227162518.A25171@confucius.usc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001227162518.A25171@confucius.usc.edu>; from rapela@sipi.usc.edu on Wed, Dec 27, 2000 at 16:25:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Dec 2000, Joaquin Rapela wrote:

> I am not a linux kernel guy. I am running a spider that sometimes gets
> blocked for long periods of time.  I run a "netstat -nto" and I
> observe a socket in state SYS_SENT that seems to be blocked. Its timer
> keeps on incrementing. 
> 
> Is there any way to avoid this blocking? Is this a bug in the kernel
> or something wrong in my TCP/IP configuration/settings.

There's something wrong with the network: Your SYN packet that is to
establish the connection to the other machine is never answered by your
"victim".

There's nothing you can do about that. Talk to non-firewalled, working
machines to prevent that. Possibly try to connect() to several sockets
at once (use fork or threads).

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
