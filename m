Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270646AbRH1Kif>; Tue, 28 Aug 2001 06:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270649AbRH1KiZ>; Tue, 28 Aug 2001 06:38:25 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:12805 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S270646AbRH1KiR>; Tue, 28 Aug 2001 06:38:17 -0400
Date: Tue, 28 Aug 2001 12:41:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Rohland <cr@sap.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] zero-bounce block highmem I/O, #13
Message-ID: <20010828124125.I642@suse.de>
In-Reply-To: <20010827123700.B1092@suse.de> <m3itf85vlr.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3itf85vlr.fsf@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28 2001, Christoph Rohland wrote:
> Hi Jens,
> 
> I tested both #11 and #13 on my 8GB machine with sym53c8xx. The
> initialization of a SAP DB database takes 20 minutes with 2.4.9 and
> with 2.4.9+b13 it took nearly 2.5 hours :-(

Hmm that sounds _very_ strange indeed. What does the controller + disk
detection info look like?

Could you attach vmstat 1 info for pristine and b13 so I can compare the
two and get a clue as to what is going on? Thanks.

-- 
Jens Axboe

