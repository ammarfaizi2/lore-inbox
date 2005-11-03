Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbVKCXqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbVKCXqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030540AbVKCXqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:46:21 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:33075 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030539AbVKCXqU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:46:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ePyeTizSdiB7XCpBGQM/hyfuU3wk4PLxbF99N1uArlvp+TMwJwWpGJfhgE7uw8uSAfn3NVUKqQapV0KuC5QtaUnrsfLN3txHKpehDq/+JMRUBjk+nDnXysbqa/XAzv/hmePg0qdKGQPR4idILhJPLNWD5nGuoASwx+WIzWRpzxI=
Message-ID: <5a4c581d0511031546k537392adg1a5f68a35072b310@mail.gmail.com>
Date: Fri, 4 Nov 2005 00:46:19 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: 2.6.14-git6.{gz,bz2} patches on kernel.org are empty
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490511031509p16623571xf4c77df4881f4b18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0511030525y8d587f9x880281abaffbf50c@mail.gmail.com>
	 <9a8748490511031509p16623571xf4c77df4881f4b18@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 11/3/05, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> > .log is present, .gz and .bz2 patches are empty.
> >
>
> I just downloaded the .gz and -bz2 files of the 2.6.14-git6 patches
> from kernel.org and they are far from empty :
>
> $ ls -l patch-2.6.14-git6.*
> -rw-r--r--  1 juhl users 2896172 2005-11-04 00:10 patch-2.6.14-git6.bz2
> -rw-r--r--  1 juhl users 3552327 2005-11-04 00:10 patch-2.6.14-git6.gz
>
> Also, extracting the files yields nice working patches.
>
> You must have a broken download or similar problem. The patches are fine.

Yes, now they are. 10 hours ago, not so.

This is a report from someone who tried two hours later than me:

http://www.ussg.iu.edu/hypermail/linux/kernel/0511.0/0950.html

No download problems at all... fairly regular -gitX tester here:

[asuardi@incident src]$ ls -ltr .config-2.6.14*
-rw-r--r--  1 asuardi asuardi 35313 Sep 20 00:43 .config-2.6.14-rc1
-rw-r--r--  1 asuardi asuardi 35388 Sep 24 21:01 .config-2.6.14-rc1-git5
-rw-r--r--  1 asuardi asuardi 35450 Oct  2 17:14 .config-2.6.14-rc2-git4
-rw-r--r--  1 asuardi asuardi 35519 Oct  4 15:23 .config-2.6.14-rc3-git2
-rw-r--r--  1 asuardi asuardi 35552 Oct  7 21:01 .config-2.6.14-rc3-git4
-rw-r--r--  1 asuardi asuardi 35583 Oct  9 23:53 .config-2.6.14-rc3-git7
-rw-r--r--  1 asuardi asuardi 35583 Oct 12 14:31 .config-2.6.14-rc3-git8
-rw-r--r--  1 asuardi asuardi 35583 Oct 14 09:45 .config-2.6.14-rc4-git1
-rw-r--r--  1 asuardi asuardi 35583 Oct 15 05:21 .config-2.6.14-rc4-git2
-rw-r--r--  1 asuardi asuardi 35608 Oct 17 20:47 .config-2.6.14-rc4-git4
-rw-r--r--  1 asuardi asuardi 35608 Oct 18 22:44 .config-2.6.14-rc4-git5
-rw-r--r--  1 asuardi asuardi 35608 Oct 19 14:50 .config-2.6.14-rc4-git6
-rw-r--r--  1 asuardi asuardi 35608 Oct 21 00:17 .config-2.6.14-rc4-git7
-rw-r--r--  1 asuardi asuardi 35608 Oct 25 14:10 .config-2.6.14-rc5-git1
-rw-r--r--  1 asuardi asuardi 35608 Oct 28 07:50 .config-2.6.14-rc5-git5
-rw-r--r--  1 asuardi asuardi 35599 Oct 29 14:57 .config-2.6.14
-rw-r--r--  1 asuardi asuardi 35607 Oct 30 15:25 .config-2.6.14-git1
-rw-r--r--  1 asuardi asuardi 35634 Oct 31 14:48 .config-2.6.14-git2
-rw-r--r--  1 asuardi asuardi 35928 Nov  1 15:04 .config-2.6.14-git3
-rw-r--r--  1 asuardi asuardi 35916 Nov  2 20:18 .config-2.6.14-git4
-rw-r--r--  1 asuardi asuardi 35916 Nov  3 14:22 .config-2.6.14-git5

You must be slacking on checking kernel.org patches, that's why
 you didn't notice :)

--alessandro

 "So much can happen by accident
  No rhyme, no reason - no one's innocent"

   (Steve Wynn - "Under The Weather")
