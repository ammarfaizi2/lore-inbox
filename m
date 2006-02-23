Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWBWVOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWBWVOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWBWVOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:14:36 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:48697 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751783AbWBWVOf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:14:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PVJ76TpAVCTofjJCgFaOdZbkbqdFaQoATh0DoMOQ0Kb5yUzduaa5TmBUuDuYVPdnY13gMUJfzhaGz1bPWr0Wyjhf0tW6I5DnJt3ycUvP9dapf6CyyrcDRR5SHvg4pLC/rL4C58gEjKfWUzrLKjvd88McGuvlTtm8KxUuvIJd3nY=
Message-ID: <29495f1d0602231314m6ea84f85wc2792c1b6b7c4715@mail.gmail.com>
Date: Thu, 23 Feb 2006 13:14:34 -0800
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
Cc: "Gautam H Thaker" <gthaker@atl.lmco.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060223210844.GA26701@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43FE134C.6070600@atl.lmco.com> <20060223205851.GA24321@elte.hu>
	 <29495f1d0602231306o55d759d5v9600b070a4b485e3@mail.gmail.com>
	 <20060223210844.GA26701@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
>
> > Would it make more sense to compare 2.6.15 and 2.6.15-rt17, as opposed
> > to 2.6.12-1.1390_FC4 and 2.6.15-rt17? Seems like the closer the two
> > kernels are, the easier it will be to isolate the differences.
>
> good point. I'd expect there to be similar 'top' output, but still worth
> doing for comparable results.

I'd also expect little difference (hopefully) -- although there's
always an off-chance something big changed somewhere and the problem
was fixed in mainline. Just makes the comparison clearer.

Thanks,
Nish
