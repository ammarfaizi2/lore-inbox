Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSLVOAN>; Sun, 22 Dec 2002 09:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSLVOAN>; Sun, 22 Dec 2002 09:00:13 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:13553 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261724AbSLVOAM>; Sun, 22 Dec 2002 09:00:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Date: Sun, 22 Dec 2002 09:08:24 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021218094714.43C712C076@lists.samba.org> <200212212341.29560.tomlins@cam.org> <20021222122817.GA12217@suse.de>
In-Reply-To: <20021222122817.GA12217@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212220908.24334.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 22, 2002 07:28 am, Dave Jones wrote:
> On Sat, Dec 21, 2002 at 11:41:29PM -0500, Ed Tomlinson wrote:
>  > Now for something new.  With bk current (6pm EST) I get:
>  > Dec 21 23:30:56 oscar kernel: Call Trace:
>  > Dec 21 23:30:56 oscar kernel:  [<e0de9108>]
>  > agp_backend_initialize+0x1c/0x168 [agpgart] Dec 21 23:30:56 oscar
>  > kernel:  [<e0de92f8>] agp_register_driver+0x2c/0xac [agpgart]
>
> I already fixed a bug with the same call-trace. This looks like
> you've still got old .o files around. Can you make clean and rebuild
> just to make sure ?

Rebuilt with make clean - I am getting the same oops...

Ed
