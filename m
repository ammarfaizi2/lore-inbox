Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161767AbWKOVto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161767AbWKOVto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161769AbWKOVto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:49:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:46844 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161766AbWKOVtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:49:42 -0500
Date: Wed, 15 Nov 2006 22:49:23 +0100
From: Chris Friedhoff <chris@friedhoff.org>
To: "Bill O'Donnell" <billodo@sgi.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-Id: <20061115224923.539fe60a.chris@friedhoff.org>
In-Reply-To: <20061115170633.GA21345@sgi.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com>
	<20061109061021.GA32696@sergelap.austin.ibm.com>
	<20061109103349.e58e8f51.chris@friedhoff.org>
	<20061113215706.GA9658@sgi.com>
	<20061114052531.GA20915@sergelap.austin.ibm.com>
	<20061114135546.GA9953@sgi.com>
	<20061114152307.GA7534@sergelap.austin.ibm.com>
	<455B0357.2050400@ak.jp.nec.com>
	<20061115170633.GA21345@sgi.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9d7f00276fac4b25ba506f26988c1e36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 11:06:34 -0600
"Bill O'Donnell" <billodo@sgi.com> wrote:

- snip - 
> | Probably, Bill didn't update libcap.so.
> No, I didn't...
> certify:~/libcap-1.10/progs # ls -altr /lib/libcap*
> -rwxr-xr-x 1 root root 22672 2006-06-16 09:56 /lib/libcap.so.1.92
> -rw-r--r-- 1 root root 53363 2006-11-13 16:04 /lib/libcap.so.1.10
> lrwxrwxrwx 1 root root    14 2006-11-13 16:04 /lib/libcap.so.1 ->libcap.so.1.92
> lrwxrwxrwx 1 root root    11 2006-11-13 16:04 /lib/libcap.so -> libcap.so.1
> 

Why is SLES10 using libcap-1.92?
(googling brought this page:
http://www.me.kernel.org/pub/linux/libs/security/linux-privs/old/kernel-2.3/)

> | 
> | But I can't recommend Bill to update libcap immediately.
> | As Hawk Xu said, it may cause a serious problem on the distro
> | except Fedora Core 6. :(
> 
> What version of libcap is on FC6? 
> 

Are there newer libcap versions then libcap-1.10 available?
(http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/)

> | 
> | I have to recommend to use 'fscaps-1.0-kg.i386.rpm' now.
> | It includes the implementation of interaction between application and xattr.
> | (Of couse, it's one of the features which should be provided by libcap.)
> 
> But that won't work on ia64 will it?

Kaigai also provides a srpm package to compile.
 VFS Capability Support -> fscaps version 1.0 [SRPM]
(http://www.kaigai.gr.jp/pub/fscaps-1.0-kg.src.rpm)

Chris


--------------------
Chris Friedhoff
chris@friedhoff.org
