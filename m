Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293039AbSCEAMB>; Mon, 4 Mar 2002 19:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293034AbSCEALw>; Mon, 4 Mar 2002 19:11:52 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:260 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S293039AbSCEALi>;
	Mon, 4 Mar 2002 19:11:38 -0500
Message-ID: <3C838DA7.4050807@namesys.com>
Date: Mon, 04 Mar 2002 18:07:19 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Oliver.Schersand@BASF-IT-Services.com
CC: Alessandro Suardi <alessandro.suardi@oracle.com>, use-oracle@suse.com,
        suse-linux-e@suse.com, mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Antwort: Re: Kernel Hangs 2.4.16 on heay io Oracle and Tivolie TSM
In-Reply-To: <OFE7517866.AA039B23-ONC1256B72.0027B52F@bcs.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver.Schersand@BASF-IT-Services.com wrote:

>Hi,
>
>on saturday a had a nice day with 16 houre to find a workaround to bring
>linux stable.
>I had moved the server from reiserfs to ext2 for all datafile areas. The
>move with tar
>runs without any crash. I had an about 60 to 75 MB/second transfer ( read +
>write) on the
>move of the oracle datafiles.
>
>After startup of oracle and backup the open datafiles ( i know this is
>nonsens but its a good stress test)
>i get a crash. On a reiserfs this would crash immediately. On ext2 crash
>happend after about 2.5houres of backup ( about 80GB datafiles).
>After this i switched backup to kernel version 2.2.19. ---> The system runs
>now without crash.
>On other server without oracle but which are have tsm backup we had no
>problems with 2.4.16 ( at the moment  only about 15 Servers)
>
>Its seems that you are right an we have a serious vm bug. This bug is only
>viewable if you user oracle and tsm (tivoli storage manager) .... Strange.
>
>Kinds regards
>
>Oliver Schersand
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
Wasn't 2.4.16 the known unstable vm release of 2.4?  Why do you go to 
such effort to stick with a bad kernel?  Go to 2.4.18.

Hans


