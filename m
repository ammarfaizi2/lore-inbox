Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292458AbSCSUBi>; Tue, 19 Mar 2002 15:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292539AbSCSUBb>; Tue, 19 Mar 2002 15:01:31 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23033
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292458AbSCSUBY>; Tue, 19 Mar 2002 15:01:24 -0500
Date: Tue, 19 Mar 2002 12:02:05 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: John Jasen <jjasen1@umbc.edu>, Mike Galbraith <mikeg@wen-online.de>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
Message-ID: <20020319200205.GW2254@matchmail.com>
Mail-Followup-To: John Jasen <jjasen1@umbc.edu>,
	Mike Galbraith <mikeg@wen-online.de>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10203191009290.5694-100000@mikeg.wen-online.de> <Pine.SGI.4.31L.02.0203190915250.7550126-100000@irix2.gl.umbc.edu> <20020319181130.GQ2254@matchmail.com> <20020319154734.GM470@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 08:47:34AM -0700, Andreas Dilger wrote:
> On Mar 19, 2002  10:11 -0800, Mike Fedyk wrote:
> > That's not the problem part of the tcpdump output.  The problem is that part
> > of an email previously read on the linux box (with no samba runing. (also,
> > no smbfs MikeG?)) showed up in the tcpdump output...
> 
> I haven't been following the whole thread, but it is _possible_ that the
> email data was written to the end of a data block which was later re-used
> for a file exported via SMB.  Depending on how the SMB code works, is it
> possible that it is sending a whole block of data to the client and/or
> not zeroing out new blocks?
> 
> Of course (not having looked at the original tcpdump output), is it
> possible that the email was captured by tcpdump because it arrived on
> the host via the network?
> 

I'm still waiting to find out what computer 10.0.0.101 is for MikeG...

But, he's not running samba or smbfs, and the email was encoded within a smb
packet...
