Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbSJVS5i>; Tue, 22 Oct 2002 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264806AbSJVS5i>; Tue, 22 Oct 2002 14:57:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48606 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261851AbSJVS5h>; Tue, 22 Oct 2002 14:57:37 -0400
Date: Tue, 22 Oct 2002 16:26:35 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Christoph Hellwig <hch@infradead.org>,
       Jan Kasprzak <kas@informatics.muni.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre11 /proc/partitions read
In-Reply-To: <20021022185958.GB26585@win.tue.nl>
Message-ID: <Pine.LNX.4.44L.0210221625440.27942-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Oct 2002, Andries Brouwer wrote:

> On Tue, Oct 22, 2002 at 07:45:14PM +0100, Christoph Hellwig wrote:
>
> > Andries, have you actually CHECKED whether he has it enabled?
>
> No.  I do not claim that his problem was caused by the stats.
> It is just that I get reports from people with mysterious mount
> and fdisk problems that go away when CONFIG_BLK_STATS is disabled.

Could you forward me these reports, please?

Thats really bad.

> And requests from RedHat to put ugly patches into mount to
> tell stdio to use a larger buffer, increasing the probability that
> all is read in one go.
>
>
> > I rather suspect it's the following bug (introduce by me, but not
> > depend on CONFIG_BLK_STATS):
>
> Good!
>
> So the very reproducible problem is solved, and only the
> sporadic random problem is left.
>
> I still hope that you will remove it again.

