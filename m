Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293245AbSC2S1h>; Fri, 29 Mar 2002 13:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310252AbSC2S1X>; Fri, 29 Mar 2002 13:27:23 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:20710 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293245AbSC2S0q>;
	Fri, 29 Mar 2002 13:26:46 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15524.45530.685067.889695@napali.hpl.hp.com>
Date: Fri, 29 Mar 2002 10:26:34 -0800
To: Andrew Morton <akpm@zip.com.au>
Cc: davidm@hpl.hp.com, Christoph Hellwig <hch@infradead.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility
In-Reply-To: <3CA4A61A.A844E21B@zip.com.au>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 29 Mar 2002 09:36:26 -0800, Andrew Morton <akpm@zip.com.au> said:

  Andrew> The way I ended up resolving these sorts of issues was to
  Andrew> make the generic function

  Andrew> 	void dump_stack(void);

  Andrew> under the (hopefully valid) assumption that all
  Andrew> architectures can somehow, in some manner, manage to spit
  Andrew> out something useful.

  Andrew> For a transitional/compatibility think, there's
  Andrew> lib/dump_stack.c which just prints "I'm broken".

  Andrew> Here's the diff.  Comments?

Looks good to me.

Thanks,

	--david
