Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293683AbSCKLBF>; Mon, 11 Mar 2002 06:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293684AbSCKLAp>; Mon, 11 Mar 2002 06:00:45 -0500
Received: from ns.ithnet.com ([217.64.64.10]:62726 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S293683AbSCKLAc>;
	Mon, 11 Mar 2002 06:00:32 -0500
Date: Mon, 11 Mar 2002 12:00:16 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020311120016.475fc854.skraw@ithnet.com>
In-Reply-To: <20020311135256.A856@namesys.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002 13:52:56 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Mon, Mar 11, 2002 at 11:46:54AM +0100, Stephan von Krawczynski wrote:
> > <4>reiserfs: checking transaction log (device 22:01) ...
> > <4>Using tea hash to sort names
> > <4>reiserfs: using 3.5.x disk format
> 
> This means you have reiserfs v3.5 format on /dev/hdc1
> And this one won't behave very good with nfs.
> Does this one contain your nfs exports?

There is _no_ /dev/hdc1.

Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda3              6297280   6146232    151048  98% /
/dev/sda2                31111     24695      4810  84% /boot
/dev/hde1             60049096  30161576  29887520  51% /p2
/dev/hdg1             20043416  16419444   3623972  82% /p3
/dev/sda4             29245432  27525524   1719908  95% /p5
shmfs                  1035112         0   1035112   0% /dev/shm

Exported fs is on /dev/hde1.

/dev/hdc could only be a cdrom, but is not in use nor mounted, and for sure has
never been related to reiserfs. 

Regards,
Stephan

