Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbQL1W2g>; Thu, 28 Dec 2000 17:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132518AbQL1W20>; Thu, 28 Dec 2000 17:28:26 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:33252 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S132517AbQL1W2P>; Thu, 28 Dec 2000 17:28:15 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
Date: 28 Dec 2000 16:57:43 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3elysi4yw.fsf@shookay.e-steel.com>
In-Reply-To: <200012261952.TAA11390@mauve.demon.co.uk> <Pine.LNX.4.30.0012271620530.24075-100000@rossi.itg.ie> <20001228134244.A1684@scutter.internal.splhi.com>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 978040585 2088 192.168.3.43 (28 Dec 2000 21:56:25 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 28 Dec 2000 21:56:25 GMT
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timw@splhi.com (Tim Wright) writes:

> On Wed, Dec 27, 2000 at 04:23:43PM +0000, Paul Jakma wrote:
> > On Tue, 26 Dec 2000, Ian Stirling wrote:
> > 
> > > The PCI bus can move around 130MB/sec,
> > 
> > in bursts yes, but sustained data bandwidth of PCI is a lot lower,
> > maybe 30 to 50MB/s. And you won't get sustained RAID performance >
> > sustained PCI performance.
> > 
> 
> No. A well-designed card and driver doing cache-line sized transfers can
> achieve ~100MB/s. On the IBM (Sequent) NUMA machines, we achieved in excess
> of 3GB/s sustained read I/O (database full table scan) on a 16-quad (32 PCI
> bus) system. That works out at around 100MB/s per bus.

Sadly, I am sure that your "well-designed" system must be costly as
hell... :(

-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
