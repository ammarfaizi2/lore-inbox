Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312344AbSCaGxt>; Sun, 31 Mar 2002 01:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312161AbSCaGxj>; Sun, 31 Mar 2002 01:53:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18449 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312158AbSCaGx1>;
	Sun, 31 Mar 2002 01:53:27 -0500
Message-ID: <3CA6B210.D5AE5D7A@zip.com.au>
Date: Sat, 30 Mar 2002 22:52:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: Linux 2.4.19-pre5
In-Reply-To: <20020330135333.A16794@rushmore> <3CA616B2.1F0D8A76@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> I'll get the rest of the -aa VM patches up at the above URL
> soonish.

http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre5/aa1/

Rediffed, retested.

>  I seem to have found a nutty workload which is returning
> extremely occasional allocation failures for GFP_HIGHUSER
> requests, which will deliver fatal SIGBUS at pagefault time.
> There's plenty of swap available, so this is a snag.

False alarm.  My test app was not handling SIGBUS inside its SIGBUS
handler. 

-
