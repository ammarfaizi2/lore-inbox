Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275632AbRJAWIe>; Mon, 1 Oct 2001 18:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275637AbRJAWIZ>; Mon, 1 Oct 2001 18:08:25 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:17887 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S275632AbRJAWIN>; Mon, 1 Oct 2001 18:08:13 -0400
Message-ID: <3BB8E9ED.B83BD8B8@oracle.com>
Date: Tue, 02 Oct 2001 00:10:53 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.11-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.11-pre2
In-Reply-To: <Pine.LNX.4.33.0110011438230.990-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Available in the usual places..
> 

There is a leftover wakeup_bdflush(0) in sysrq.c, I guess
 it should be wakeup_bdflush(). Well at least it builds
 after the above fix :)

--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
