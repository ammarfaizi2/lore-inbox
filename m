Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130457AbRBAQS6>; Thu, 1 Feb 2001 11:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130851AbRBAQSs>; Thu, 1 Feb 2001 11:18:48 -0500
Received: from zeus.kernel.org ([209.10.41.242]:23529 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130457AbRBAQSc>;
	Thu, 1 Feb 2001 11:18:32 -0500
Date: Thu, 1 Feb 2001 16:16:15 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: bsuparna@in.ibm.com, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201161615.T11607@redhat.com>
In-Reply-To: <CA2569E6.0051970D.00@d73mta03.au.ibm.com> <20010201160953.A17058@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010201160953.A17058@caldera.de>; from hch@caldera.de on Thu, Feb 01, 2001 at 04:09:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 04:09:53PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 01, 2001 at 08:14:58PM +0530, bsuparna@in.ibm.com wrote:
> > 
> > That would require the vfs interfaces themselves (address space
> > readpage/writepage ops) to take kiobufs as arguments, instead of struct
> > page *  . That's not the case right now, is it ?
> 
> No, and with the current kiobufs it would not make sense, because they
> are to heavy-weight.

Really?  In what way?  

> With page,length,offsett iobufs this makes sense
> and is IMHO the way to go.

What, you mean adding *extra* stuff to the heavyweight kiobuf makes it
lean enough to do the job??

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
