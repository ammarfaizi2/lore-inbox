Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSLJSxh>; Tue, 10 Dec 2002 13:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSLJSxg>; Tue, 10 Dec 2002 13:53:36 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:35304
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261302AbSLJSxf>; Tue, 10 Dec 2002 13:53:35 -0500
Message-ID: <3DF63A0C.6010708@redhat.com>
Date: Tue, 10 Dec 2002 11:01:32 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Hu, Boris" <boris.hu@intel.com>
CC: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>,
       "NPTL list (E-mail)" <phil-list@redhat.com>
Subject: Re: problem about CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID ?
References: <957BD1C2BF3CD411B6C500A0C944CA260216C261@pdsmsx32.pd.intel.com>
In-Reply-To: <957BD1C2BF3CD411B6C500A0C944CA260216C261@pdsmsx32.pd.intel.com>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hu, Boris wrote:

>  I have searched CLONE_PARENT_SETTID in kernel, it seems only to appear in 
> some non-architecture files, such as /include/linux/sched.h and several arch
> files,
>  but they do little about wrapping.  Why ARM can't support 
> (CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID)? 
> 
> any comments? thanks a lot. 

Follow the kernel mailing lists.  It's not adequate to ask these
questions here.  If you would have read the kernel mailing list posts it
would have been obvious that every single architecture needs changes to
the kernel.  Nobody cared for Arm so far so there obviously is no kernel
support.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE99joM2ijCOnn/RHQRAsyaAJ4khzPYopcMqxUSxOsnXf+r5qPD+ACfST14
51FpBVTFUFO6A9WwAOgX5EU=
=2xM9
-----END PGP SIGNATURE-----

