Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280638AbRLDE1G>; Mon, 3 Dec 2001 23:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280592AbRLDE04>; Mon, 3 Dec 2001 23:26:56 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:17794 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280434AbRLDE0x>; Mon, 3 Dec 2001 23:26:53 -0500
Message-ID: <3C0C508C.40407@redhat.com>
Date: Mon, 03 Dec 2001 23:26:52 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> this patch is slightly differerent from the last one i posted.
> 
> it's still diffed against 2.4.17pre1. one obvious thinko is fixed, and a 
> couple lines that looked bad to me have been changed (goto end in 
> i810_read seems to be necessary to clean up the wait queue unless I'm 
> mistaken), and I'm no longer reproducing any OOPSes.
> 
> however, i am seeing artsd segfault occasionally. this also seems to 
> happen with the 4Front driver, however, at least if I load 4Front's 
> module after unloading this patched driver. I'm not sure if this is a 
> bug in artsd or specific to my setup or something nasty i've done to my 
> kernel's data structures ;) so maybe somebody else who's still having 
> problems with 2.4.17pre1 and KDE can take a look and see how it works 
> for them.


Nathan, thanks for taking the time to merge these.  I've got some more 
stuff here that I've done just recently for ANK, and a few moments of 
spare time.  If you'll send me the last version of the .c file you had, 
I can probably do a pretty quick merge of everthing together (I need the 
.c file instead of the patch because I'm not starting from the same 
source you are).  Hopefully, between your efforts and the feedback I've 
gotten in the last few days, we can send a final version to Marcello for 
the 2.4 kernel series that actually works well.




-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

