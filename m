Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131186AbRAIU5R>; Tue, 9 Jan 2001 15:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131642AbRAIU5K>; Tue, 9 Jan 2001 15:57:10 -0500
Received: from smtpgw.bnl.gov ([130.199.3.16]:9739 "EHLO smtpgw.sec.bnl.local")
	by vger.kernel.org with ESMTP id <S129562AbRAIU47>;
	Tue, 9 Jan 2001 15:56:59 -0500
Date: Tue, 9 Jan 2001 15:56:11 -0500
From: Tim Sailer <sailer@bnl.gov>
To: John Heffner <jheffner@psc.edu>
Cc: linux-kernel@vger.kernel.org, jfung@bnl.gov
Subject: Re: Network Performance?
Message-ID: <20010109155611.B3563@bnl.gov>
In-Reply-To: <20010109115302.A32135@bnl.gov> <Pine.NEB.4.05.10101091423060.3675-100000@dexter.psc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.NEB.4.05.10101091423060.3675-100000@dexter.psc.edu>; from jheffner@psc.edu on Tue, Jan 09, 2001 at 02:29:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 02:29:36PM -0500, John Heffner wrote:
> > --------------------------------------------
> > ports:/home/ftp# sysctl -a | fgrep net/core
> > net/core/optmem_max = 10240
> > net/core/message_burst = 50
> > net/core/message_cost = 5
> > net/core/netdev_max_backlog = 300
> > net/core/rmem_default = 32767			<<<<<<<<<
> > net/core/wmem_default = 32767			<<<<<<<<<
> > net/core/rmem_max = 2097152
> > net/core/wmem_max = 2097152
> > --------------------------------------------
> 
> The defaults must be large unless your application calls setsockopt() to
> set the buffers itself.  (Some FTP clients and servers can do this, but
> for testing, your're still probably better always having the _max's and
> _default's the same.)

Hm.. OK. I think we tried that, but I'll check again.

Thanks,
Tim

-- 
Tim Sailer <sailer@bnl.gov> Cyber Security Operations
Brookhaven National Laboratory  (631) 344-3001
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
