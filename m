Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273429AbRI0Psg>; Thu, 27 Sep 2001 11:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273424AbRI0Ps0>; Thu, 27 Sep 2001 11:48:26 -0400
Received: from web13307.mail.yahoo.com ([216.136.175.43]:3859 "HELO
	web13307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273414AbRI0PsQ>; Thu, 27 Sep 2001 11:48:16 -0400
Message-ID: <20010927154840.74967.qmail@web13307.mail.yahoo.com>
Date: Thu, 27 Sep 2001 08:48:40 -0700 (PDT)
From: Carl Spalletta <cspalletta@nectarsystems.com>
Subject: Re: max arguments for exec
To: vkire@pixar.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, Kiril Vidimce wrote:
 
> Yeah, I know, but we would like to avoid building a
custom kernel. If
> we do end up going this route, I wonder if there is
a limit for
> MAX_ARG_PAGES. Any idea? I think 128 pages (512K)
would be sufficient
> for our needs.

kiril, 

I am guessing that you want to avoid a custom kernel
in order that your programs shall be portable.

So, I am having a hard time understanding why putting
the command line args into a file instead of on the
command line, in a way similar to grep and many other
programs:
 
"fgrep -F patternfile"

would not answer the case.

Is there any absolute need to have so many args passed
to exec from the command line?


__________________________________________________
Do You Yahoo!?
Listen to your Yahoo! Mail messages from any phone.
http://phone.yahoo.com
