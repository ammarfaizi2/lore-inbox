Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUEYWUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUEYWUC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUEYWT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:19:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32910 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265161AbUEYWT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:19:26 -0400
Date: Wed, 26 May 2004 00:20:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@osdl.org, riel@redhat.com, andrea@suse.de, torvalds@osdl.org,
       phyprabab@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Message-ID: <20040525222031.GA11436@elte.hu>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525141622.49e86eb9.akpm@osdl.org> <20040525214817.GA21112@elte.hu> <20040525150916.6f385bc9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525150916.6f385bc9.davem@redhat.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David S. Miller <davem@redhat.com> wrote:

> > hm, 1.5K pretty much seems to be the standard. Plus large frames can be
> > scatter-gathered via fragmented skbs. Seldom is there a need for a large
> > skb to be linear.
> 
> Unfortunately TSO with non-sendfile apps makes huge 64K SKBs get
> built.

hm, shouldnt we disable TSO in this case - or is it a win even in this
case?

	Ingo
