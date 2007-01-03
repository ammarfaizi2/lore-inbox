Return-Path: <linux-kernel-owner+w=401wt.eu-S932157AbXACW3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbXACW3l (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbXACW3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:29:41 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:44993 "EHLO smtp.hispeed.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932157AbXACW3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:29:39 -0500
X-Greylist: delayed 2586 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 17:29:39 EST
Subject: Re: kernel + gcc 4.1 = several problems
From: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Grzegorz Kulewski <kangur@polcom.net>, Alan <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
In-Reply-To: <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
	 <20070103102944.09e81786@localhost.localdomain>
	 <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
	 <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 22:44:19 +0100
Message-Id: <1167860659.13394.41.camel@unreal>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-06.tornado.cablecom.ch 1378;
	Body=11 Fuz1=11 Fuz2=11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 08:03 -0800, Linus Torvalds wrote:

> and assuming the branch is AT ALL predictable (and 95+% of all branches 
> are), the branch-over will actually be a LOT better for a CPU.

IF... Counterexample: Add-Compare-Select in a Viterbi Decoder. If the
compare can be predicted, you botched the compression of the data (if
you can predict the data, you could have compressed it better), or your
noise is not white, i.e. you f*** up the whitening filter. So in any
practical viterbi decoder, the compares cannot be predicted. I remember
cmov made a big difference in Viterbi Decoder performance on a Cyrix
6x86. But granted, nowadays these things are usually done with SIMD and
masks.

Tom

