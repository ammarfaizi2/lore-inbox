Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265071AbSJWQc6>; Wed, 23 Oct 2002 12:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSJWQc6>; Wed, 23 Oct 2002 12:32:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62176 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265071AbSJWQc5>; Wed, 23 Oct 2002 12:32:57 -0400
Message-ID: <3DB6CF9E.327E165F@us.ibm.com>
Date: Wed, 23 Oct 2002 09:34:38 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: bert hubert <ahu@ds9a.nl>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT sockets? (was [RESEND] tuning linux for high network 
 performance?)
References: <200210231218.18733.roy@karlsbakk.net> <20021023130101.GA646@outpost.ds9a.nl> <3DB6B96F.A0DE47BF@us.ibm.com> <200210231726.21135.roy@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:

> I'm doing O_DIRECT read (from disk), so it needs to be user -> kernel, then.
> 
> any chance of using O_DIRECT to the socket?

Hmm, I'm still not clear on why you cannot use sendfile()?
I was not aware of any upper limit to the file size in order
for sendfile() to be used?  From what little I know, this 
is exactly the kind of situation that sendfile was intended
to benefit. 

thanks,
Nivedita
