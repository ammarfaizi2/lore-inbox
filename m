Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282482AbRL1Qpq>; Fri, 28 Dec 2001 11:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282511AbRL1Qpg>; Fri, 28 Dec 2001 11:45:36 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:32528 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S282482AbRL1Qp1>;
	Fri, 28 Dec 2001 11:45:27 -0500
Date: Fri, 28 Dec 2001 17:45:10 +0100
From: Jan Niehusmann <list064@gondor.com>
To: andersg@0x63.nu
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        lvm-devel@sistina.com
Subject: Re: lvm in 2.5.1
Message-ID: <20011228164510.GA9129@gondor.com>
Reply-To: Jan Niehusmann <jan@gondor.com>
Mail-Followup-To: Jan Niehusmann <list064@gondor.com>, andersg@0x63.nu,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	lvm-devel@sistina.com
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se> <3C2B75B3.4DEF90D3@zip.com.au> <20011227193711.GB20501@h55p111.delphi.afb.lu.se> <3C2B7A3E.E5C05404@zip.com.au> <20011227202451.GC20501@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227202451.GC20501@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 09:24:51PM +0100, andersg@0x63.nu wrote:
> hmm, enlarging the dummy[200] in the userspace version of lv_t seems to be a
> nice quickndirty solution.

Please do not change the kernel / userspace interface easily. Past
experience has shown that this leads to significant update problems,
because kernel and userspace tools need to be updated at the same time.

Jan

