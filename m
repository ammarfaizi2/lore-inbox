Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSJINlH>; Wed, 9 Oct 2002 09:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261671AbSJINlH>; Wed, 9 Oct 2002 09:41:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14340 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261668AbSJINlH>;
	Wed, 9 Oct 2002 09:41:07 -0400
Message-ID: <3DA4334E.2070006@pobox.com>
Date: Wed, 09 Oct 2002 09:46:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK] ReiserFS v3 changesets resend
References: <3DA41105.3020300@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
>     You can pull these from bk://thebsh.namesys.com/bk/reiser3-linux-2.5
> 
> Diffstats:
>  fs/reiserfs/inode.c         |    2 +-
>  include/linux/reiserfs_fs.h |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
>  super.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletion(-)
> 
>  do_balan.c        |  105 +++++++++++++++++++++++++++---------------------------
>  inode.c           |   48 ++++++++++++++++++++----
>  tail_conversion.c |    5 +-
>  3 files changed, 95 insertions(+), 63 deletions(-)


You guys need to use a better format for emailing Linus...  see his 
posts on the subject, or just use Documentation/BK-usage/bk-make-sum 
script.  Having N diffstat outputs followed by N changeset descriptions 
is just non-sensical.  Linus should not need to count down diffstats to 
figure out which one corresponds to which changeset.

Further, an overall [single] diffstat gives a better picture of what he 
will pull when he does a 'bk pull'...

	Jeff



