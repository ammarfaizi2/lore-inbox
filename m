Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264475AbRFLOKW>; Tue, 12 Jun 2001 10:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264498AbRFLOKM>; Tue, 12 Jun 2001 10:10:12 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:18803
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S264475AbRFLOJ7>; Tue, 12 Jun 2001 10:09:59 -0400
Date: Tue, 12 Jun 2001 16:09:32 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Jeremy Sanders <jss@ast.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, rsync-bugs@samba.org
Subject: Re: rsync hangs on RedHat 2.4.2 or stock 2.4.4
Message-ID: <20010612160931.E27591@jaquet.dk>
In-Reply-To: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk>; from jss@ast.cam.ac.uk on Tue, Jun 12, 2001 at 02:59:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 02:59:12PM +0100, Jeremy Sanders wrote:
> I'm getting numerous rsync (v2.4.6) problems under Linux 2.4.2 (RedHat
> 7.1) or stock 2.4.4 on several machines. rsync often hangs copying files
> from NFS or local disks to local disks. Strangely the problem is fixed by
> stracing one of the three rsync threads!
> 
[...]
> Has anyone else encountered this problem? Is it a kernel problem or an
> rsync problem?

I encountered this exact problem some time ago. Some discussion
but in the end the problem was blamed on rsync and nothing came
of it. I'll post an URL to the thread later on when I have the
time to dig it out.

I could swear that during early 240-testX this was not a problem,
but when I finally made a report about it and tried to go back
through earlier kernels, I could not reproduce. Also, this is
not reproducable under 2.2.X (for me, at least).

Regards,
  Rasmus
