Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263588AbTCULFn>; Fri, 21 Mar 2003 06:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263590AbTCULFn>; Fri, 21 Mar 2003 06:05:43 -0500
Received: from pat.uio.no ([129.240.130.16]:11145 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S263588AbTCULFm>;
	Fri, 21 Mar 2003 06:05:42 -0500
To: Vladimir Serov <vserov@infratel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
References: <20030318155731.1f60a55a.skraw@ithnet.com>
	<3E79EAA8.4000907@infratel.com>
	<15993.60520.439204.267818@charged.uio.no>
	<3E7ADBFD.4060202@infratel.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 21 Mar 2003 12:16:35 +0100
In-Reply-To: <3E7ADBFD.4060202@infratel.com>
Message-ID: <shsof45nf58.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Vladimir Serov <vserov@infratel.com> writes:

     > Trond Myklebust wrote:
    >>>>>>> " " == Vladimir Serov <vserov@infratel.com> writes:
    >>>>>>>

    >>
    >> > interrupt handler for NIC, it's gone !!!  IMHO this is due to
    >> > the race in the nfs client.
    >>
    >> Why would an NFS race show up only on PPC? Do you have a
    >> tcpdump?
    >>

     > Hi , Trond As I wrote , another persone has similar problems on
     > PC's, as to me it was a big suprise to see such a problem in

No that wasn't the same problem. IIRC that other person had faulty
hardware. To my knowledge, there are no outstanding problems with
hangs under 2.4.x.

     > nfs, cause i'm using it for over 10 yers in a different
     > setups's OS's , etc. Yes I have tcpdump , and as i wrote,
     > nothing wrong is going on with packet receiption, where is now
     > corrupted packets , no error messages, NOTHING !!!! Just RPC

Can I see that tcpdump in order to judge that for myself?

Cheers,
  Trond
