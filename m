Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132450AbQKDNOI>; Sat, 4 Nov 2000 08:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132710AbQKDNN7>; Sat, 4 Nov 2000 08:13:59 -0500
Received: from zeus.kernel.org ([209.10.41.242]:29969 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132450AbQKDNNw>;
	Sat, 4 Nov 2000 08:13:52 -0500
Date: Sat, 4 Nov 2000 13:12:06 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org, jeremy@goop.org,
        "David S. Miller" <davem@redhat.com>, rgooch@atnf.csiro.au,
        sct@redhat.com
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
Message-ID: <20001104131206.A10822@redhat.com>
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org> <3A033A45.D8F6E952@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A033A45.D8F6E952@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Nov 03, 2000 at 05:20:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 03, 2000 at 05:20:53PM -0500, Jeff Garzik wrote:
> 
> >      * kiobuf seperate lock functions/bounce/page_address fixes
> 
> Do Stephen Tweedie's recently posted kiobuf patches fix this issue?

Hopefully, but not 100%: there is still a race window on anonymous
pages which needs to be fixed elsewhere in the VM.  The window for
mmaped files is closed in those patches, though.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
