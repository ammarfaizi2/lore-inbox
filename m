Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXVzp>; Wed, 24 Jan 2001 16:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129445AbRAXVzg>; Wed, 24 Jan 2001 16:55:36 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:25560
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S129406AbRAXVzY>; Wed, 24 Jan 2001 16:55:24 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCD7@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'Mathieu Chouquet-Stringer'" <mchouque@e-steel.com>,
        linux-kernel@vger.kernel.org
Subject: RE: [UPDATE] Zerocopy patches, against 2.4.1-pre10
Date: Wed, 24 Jan 2001 16:52:19 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What are "zerocopy patch set"s?
> 
> Basically, if you want to send something to the network, the 
> kernel has to
> copy your data to its memory space. It is an overhead and with these
> patches, the kernel doesn't has to do it. So it is faster. 
> Moreover, few
> ethernet cards are able to compute the ip checksum so linux 
> doesn't need
> anymore to do that.

Hmm.. so things like routing should be faster then?  What caveats should one
watch for (ie: what functionalities will not work as before - if any)?

Cheers!
Jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
