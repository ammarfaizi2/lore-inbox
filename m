Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUHSKxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUHSKxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 06:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUHSKxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 06:53:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:7301 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265124AbUHSKxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 06:53:14 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040817191819.GA19449@thunk.org>
References: <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <1092374851.3450.13.camel@mindpipe> <1092375673.3450.15.camel@mindpipe>
	 <20040813103151.GH8135@elte.hu>
	 <1092699974.13981.95.camel@krustophenia.net>
	 <20040817074826.GA1238@elte.hu>  <20040817191819.GA19449@thunk.org>
Content-Type: text/plain
Message-Id: <1092912869.810.12.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 06:54:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 15:18, Theodore Ts'o wrote:
> On Tue, Aug 17, 2004 at 09:48:26AM +0200, Ingo Molnar wrote:
> > there's another thing you could try: various SHA_CODE_SIZE values in
> > drivers/char/random.c. Could you try 1, 2 and 3, does it change the
> > overhead as seen in the trace?
> 
> I doubt SHA_CODE_SIZE will make a sufficient difference to avoid the
> latency problems.

Correct, the difference is less than 50%.  I will try the patch.

Lee

