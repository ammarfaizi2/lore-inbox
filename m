Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288460AbSA3Eed>; Tue, 29 Jan 2002 23:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288473AbSA3EeY>; Tue, 29 Jan 2002 23:34:24 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:20748 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S288460AbSA3EeQ>; Tue, 29 Jan 2002 23:34:16 -0500
Date: Wed, 30 Jan 2002 04:34:03 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Cc: jpaana@s2.org
Subject: Re: How to avoid zombie kernel threads?
Message-ID: <20020130043403.GA97130@compsoc.man.ac.uk>
In-Reply-To: <m3hep4qy79.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hep4qy79.fsf@kalahari.s2.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *16VmRl-000Dgm-00*MLxOdunZiV6* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 06:06:50AM +0200, Jarno Paananen wrote:

> http://hardsid.sourceforge.net/ is someone is actually interested)
> that uses a kernel thread to do the actual work asynchronously from
> rest of the world. The thread is created when opening a character
> device and exits when the device is closed.

read frey's guide and look at some real code to see how to do this.

Think you are missing a reparent_to_init(). I don't know if bleeding
2.5 includes this in daemonize() yet.

You should really have asked this on kernelnewbies mailing list btw

http://www.kernelnewbies.org/

regards
john

-- 
"In no sense is [in]stability a reason to move to a new version. It's never a
reason."
	- Bill Gates
