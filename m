Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbULXLys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbULXLys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 06:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbULXLys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 06:54:48 -0500
Received: from web51506.mail.yahoo.com ([206.190.38.198]:22945 "HELO
	web51506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261393AbULXLyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 06:54:44 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=NWdftIkDQD+gQpIEZgjoAehQwjdUqk6J91gCi7a36YzQEHK6MQ7bJllSG5+IsJWkJDsU6aq7vkW0XEi1vBfHHEAePfZz7OZloKizJJ/sD3nqrscmD87qiHFS5cYaNKmqJG6jZpQfD3PW93uQyY3gXSwaI1fZJ8r9u8cT49XxjxE=  ;
Message-ID: <20041224115443.55225.qmail@web51506.mail.yahoo.com>
Date: Fri, 24 Dec 2004 03:54:43 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: What's wrong with Documentation/DocBook/kernel-api.tmpl? (was Re: Something wrong when transform Documentation/DocBook/*.tmpl into pdf)
To: adobriyan@mail.ru
Cc: sam@ravnborg.org, juhl-lkml@dif.dk, twaugh@redhat.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004 at 23:33, Alexey Dobriyan wrote:
>
> On 2004-12-23 19:39:25, Park Lee wrote:
> > cd
/usr/src/linux-2.6.5-1.358/Documentation/DocBook
<ENTER>
> > make pdfdocs  <ENTER>
>
> Correct sequence is:
>
> $ cd /usr/src/linux-whatever/
> $ make pdfdocs
>
> pdfs will be at Documentation/DocBook/

I run the commands as what you said, and it really
works!
But there is still one problem: All the other *.tmpl
in Documentation/DocBook can be transformed into pdf
except the kernel-api.sgml.

When I ran the commands, It said on the screen like
the following:

[root@lenovo linux-2.6.5-1.358]# make pdfdocs
  [snipped]
DOCPROC Documentation/DocBook/kernel-api.sgml
Warning(lib/string.c:459): No description found for
parameter 'srcp'
Warning(lib/string.c:459): No description found for
parameter 'destp'
Warning(lib/string.c:459): No description found for
parameter 'srcp'
Warning(lib/string.c:459): No description found for
parameter 'destp'
Warning(include/asm-i386/uaccess.h:564): No
description found for parameter 'dst '
Warning(include/asm-i386/uaccess.h:564): No
description found for parameter 'src '
Warning(include/asm-i386/uaccess.h:564): No
description found for parameter 'cou nt'
Error(fs/dcache.c:687): cannot understand prototype:
'DENTRY_UNUSED_THRESHOLD 30 000 '
Warning(include/linux/skbuff.h:275): No description
found for parameter 'head,*d ata,*tail,*end'
Warning(net/core/dev.c:794): No description found for
parameter 'newname'
Warning(drivers/net/8390.c:1031): No description found
for parameter 'size'
Warning(drivers/block/ll_rw_blk.c:568): No description
found for parameter 'tags '
Warning(drivers/block/ll_rw_blk.c:1155): No
description found for parameter 'q'
Warning(drivers/block/ll_rw_blk.c:1826): No
description found for parameter 'bio '
Warning(drivers/video/console/fbcon.c): no structured
comments found
make[1]: *** [Documentation/DocBook/kernel-api.sgml]
Error 1
make: *** [pdfdocs] Error 2

  Then, what's wrong with kernel-api.tmpl? Why
couldn't it be transformed into pdf?

  Thank you. 


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - What will yours do?
http://my.yahoo.com 
