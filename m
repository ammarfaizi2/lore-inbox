Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277629AbRJ1ENh>; Sun, 28 Oct 2001 00:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277665AbRJ1EN2>; Sun, 28 Oct 2001 00:13:28 -0400
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:61430 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S277629AbRJ1ENT>; Sun, 28 Oct 2001 00:13:19 -0400
From: junio@siamese.dhis.twinsun.com
To: Tim Waugh <twaugh@redhat.com>
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: linux-2.4.12 / linux-2.4.13 parallel port problem
In-Reply-To: <20011024230917.H7544@redhat.com>
	<ioWB7.5038$rR5.921319585@newssvr17.news.prodigy.com>
	<20011025165226.T7544@redhat.com>
	<7vofmuu9d7.fsf@siamese.dhis.twinsun.com>
	<20011026104125.Z7544@redhat.com>
Date: 27 Oct 2001 21:14:21 -0700
In-Reply-To: <20011026104125.Z7544@redhat.com>
Message-ID: <7vbsiss8o2.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "TW" == Tim Waugh <twaugh@redhat.com> writes:

TW> On Fri, Oct 26, 2001 at 12:51:48AM -0700, junio@siamese.dhis.twinsun.com wrote:
>> >From the original poster's description, 2.4.10 claimed to have
>> detected both address and irq for parport0, while 2.4.12,
>> according to the your response, could not tell that IRQ=7.  Do
>> you mean that the logic which made 2.4.10 to claime to have
>> detected IRQ=7 was faulty and the logic in 2.4.12 is being
>> careful not to misdetect?

TW> Oh, I see.  No, this is a regression.  Please try this patch:

Thanks.  It (actually 2.4.13-ac2) does seem to fix the problem
for my laptop.
