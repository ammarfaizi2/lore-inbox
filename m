Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbSLJXXk>; Tue, 10 Dec 2002 18:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266897AbSLJXXk>; Tue, 10 Dec 2002 18:23:40 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:34815 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S266888AbSLJXXj>; Tue, 10 Dec 2002 18:23:39 -0500
Message-ID: <3DF67878.6090703@oracle.com>
Date: Wed, 11 Dec 2002 00:27:52 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools 0.9.3 -- "missing" issue
References: <20021210231301.1301B2C078@lists.samba.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <2105495.1039535073217.JavaMail.nobody@web55.us.oracle.com> you write:
> 
>>As per the README...

[snip]

> 
> Hmm, you don't need to run aclocal, automake and autoconf if you don't
> alter the sources.  I have altered the README to put that at the
> bottom:
> 
> 5) If you want to hack on the source:
> 	aclocal && automake --add-missing --copy && autoconf
> 
> Thanks for the report!

Thanks for the clarification. Just wanted to add that following
  Rusty Lynch's hint to ignore the 'missing' issue I successfully
  installed 0.9.3 and they appear to work on 2.5.51 (I was able
  to modprobe vfat - but not the full irda stack, I'll report this
  separately to Jean) _and_ on 2.4.20 (modular IrDA and PPP are
  channeling this message to you - loaded by 0.9.3 :).

--alessandro

  "Seems that you can't get any more than half free"
        (Bruce Springsteen, "Straight Time")

