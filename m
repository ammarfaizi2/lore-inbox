Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbRGPPn7>; Mon, 16 Jul 2001 11:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbRGPPnt>; Mon, 16 Jul 2001 11:43:49 -0400
Received: from geos.coastside.net ([207.213.212.4]:25540 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S267330AbRGPPni>; Mon, 16 Jul 2001 11:43:38 -0400
Mime-Version: 1.0
Message-Id: <p0510032ab778bbfd8df6@[207.213.214.37]>
In-Reply-To: <3B5307CB.1BA89A6F@uow.edu.au>
In-Reply-To: <20010716153702.A21514@lightning.swansea.linux.org.uk>
 <3B5307CB.1BA89A6F@uow.edu.au>
Date: Mon, 16 Jul 2001 08:43:23 -0700
To: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <laughing@shared-source.org>,
        crutcher+kernel@datastacks.com
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Linux 2.4.6-ac5
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:27 AM +1000 2001-07-17, Andrew Morton wrote:
>Also, my manpage says that vsnprintf should return -1
>if it truncated the output.  Your implementation
>doesn't do that, but trivially could.

My manpage says:

>Return value
>        These  functions  return  the number of characters printed
>        (not including the trailing `\0' used  to  end  output  to
>        strings).   snprintf  and vsnprintf do not write more than
>        size bytes (including the trailing '\0'), and return -1 if
>        the  output  was truncated due to this limit.  (Thus until
>        glibc 2.0.6. Since glibc 2.1 these  functions  follow  the
>        C99  standard and return the number of characters (exclud-
>        ing the trailing '\0') which would have  been  written  to
>        the final string if enough space had been available.)
>

-- 
/Jonathan Lundell.
