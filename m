Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbSJVMsv>; Tue, 22 Oct 2002 08:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSJVMsv>; Tue, 22 Oct 2002 08:48:51 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:8964 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262481AbSJVMsv>; Tue, 22 Oct 2002 08:48:51 -0400
Date: Tue, 22 Oct 2002 13:54:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: landley@trommello.org, Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Son of crunch time: the list v1.2.
Message-ID: <20021022135447.A25459@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, landley@trommello.org,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB3AB3E.23020.5FFF7144@localhost> <200210211536.25109.landley@trommello.org> <3DB4B1B9.4070303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB4B1B9.4070303@pobox.com>; from jgarzik@pobox.com on Mon, Oct 21, 2002 at 10:02:33PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 10:02:33PM -0400, Jeff Garzik wrote:
> > 11) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)
> > Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7060.html
> > Code: http://lkcd.sourceforge.net/
> 
> I would personally _love_ to see this merged, but I think it's 2.7.x 
> material given the recent comments (unless they get fixed up)

The few core changes they make are fine - the rest is purely driver work.
IMHO we should merge the core dump infrastructure (i.e. notifiers,
Kerntypes, etc..) - the rest can be added when ready and before that you
should be able to simply load an externally compiled dump.o anyway..
