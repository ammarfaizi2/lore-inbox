Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271396AbTHMGQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271399AbTHMGQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:16:03 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:28680 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S271396AbTHMGQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:16:00 -0400
Date: Wed, 13 Aug 2003 08:15:46 +0200
To: gaxt <gaxt@rogers.com>,
       Henrik =?iso-8859-15?Q?R=E6der?= Clausen <henrik@fangorn.dk>,
       Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
       "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       "Mark W. Alexander" <slash@dotnetslash.net>,
       jeff millar <wa1hco@adelphia.net>,
       Thomas Molina <tmolina@cablespeed.com>,
       Christian Mautner <chm@istop.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       Herbert =?iso-8859-15?Q?P=F6tzl?= <herbert@13thfloor.at>
Subject: SOLUTION Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030813061546.GB24994@gamma.logic.tuwien.ac.at>
References: <20030809104024.GA12316@gamma.logic.tuwien.ac.at> <1060436885.467.0.camel@teapot.felipe-alfaro.com> <3F34D0EA.8040006@rogers.com> <20030809104024.GA12316@gamma.logic.tuwien.ac.at> <20030809115656.GC27013@www.13thfloor.at> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <20030809130641.A8174@electric-eye.fr.zoreil.com> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC23@hdsmsx402.hd.intel.com> <002e01c35e87$14c1ffc0$ee52a450@theoden> <Pine.LNX.4.56.0308091036190.16795@filesrv1.baby-dragons.com> <3F3509C0.9050403@rogers.com> <Pine.LNX.4.56.0308091030590.16795@filesrv1.baby-dragons.com> <1060436885.467.0.camel@teapot.felipe-alfaro.com> <20030809115656.GC27013@www.13thfloor.at> <20030809130641.A8174@electric-eye.fr.zoreil.com> <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 12 Aug 2003, Christian Mautner wrote:
> Hast du auch einen kompletten Kernel tarball versucht? Wahrscheinlich

The solution is:
	Get a COMPLETE linux-2.6.0-test3.tar.bz2
and 
	DO NOT USE patch

I patched up the kernel from 2.5.20 or something and there seemed to be
an error somewhere on the way up. Getting a *clean* kernel tar file,
compile with the same .config, running.

This is the use of patches!

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
AINDERBY STEEPLE (n.)
One who asks you a question with the apparent motive of wanting to
hear your answer, but who cuts short your opening sentence by leaning
forward and saying 'and I'll tell you why I ask...' and then talking
solidly for the next hour.
			--- Douglas Adams, The Meaning of Liff
