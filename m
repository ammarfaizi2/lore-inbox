Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130796AbRBAQIf>; Thu, 1 Feb 2001 11:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRBAQIZ>; Thu, 1 Feb 2001 11:08:25 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:19481 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130793AbRBAQIQ>; Thu, 1 Feb 2001 11:08:16 -0500
Message-Id: <200102011608.f11G8j007752@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: hch@caldera.de, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains 
In-Reply-To: Message from Christoph Hellwig <hch@caldera.de> 
   of "Thu, 01 Feb 2001 16:09:53 +0100." <20010201160953.A17058@caldera.de> 
Date: Thu, 01 Feb 2001 10:08:45 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Feb 01, 2001 at 08:14:58PM +0530, bsuparna@in.ibm.com wrote:
> > 
> > That would require the vfs interfaces themselves (address space
> > readpage/writepage ops) to take kiobufs as arguments, instead of struct
> > page *  . That's not the case right now, is it ?
> 
> No, and with the current kiobufs it would not make sense, because they
> are to heavy-weight.  With page,length,offsett iobufs this makes sense
> and is IMHO the way to go.
> 
> 	Christoph
> 

Enquiring minds would like to know if you are working towards this 
revamp of the kiobuf structure at the moment, you have been very quiet
recently. 

Steve


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
