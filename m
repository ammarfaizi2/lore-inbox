Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261546AbTCKTxX>; Tue, 11 Mar 2003 14:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbTCKTxX>; Tue, 11 Mar 2003 14:53:23 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:64271 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261546AbTCKTxX>; Tue, 11 Mar 2003 14:53:23 -0500
Date: Tue, 11 Mar 2003 15:03:11 -0500
From: Ben Collins <bcollins@debian.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire on Linux-2.4.20
Message-ID: <20030311200311.GB379@phunnypharm.org>
References: <Pine.LNX.3.95.1030311142745.2204A-100000@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1030311142745.2204A-100000@chaos>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 02:29:39PM -0500, Richard B. Johnson wrote:
> 
> Hello FIREWIRE gurus!
> 
> I am trying to get Linux-2.4.20 running!  I need the
> IEEE1394 PCILYNX module working. The configuration has
> strangely changed since linux-2.4.18 so the required
> object file becomes an 8-byte text file!

I'd much rather see the output of this:

# rm drivers/ieee1394/pcilynx.o
# make SUBDIRS=drivers/ieee1394


Mainly, I want to see the command line and output from the kernel
command line. The pcilynx.o you shows seems to be an attempted AR
archive, which is really weird.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
