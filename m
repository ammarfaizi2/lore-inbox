Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266411AbSLVMU6>; Sun, 22 Dec 2002 07:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbSLVMU6>; Sun, 22 Dec 2002 07:20:58 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:54441 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266411AbSLVMU5>;
	Sun, 22 Dec 2002 07:20:57 -0500
Date: Sun, 22 Dec 2002 12:28:17 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Message-ID: <20021222122817.GA12217@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
References: <20021218094714.43C712C076@lists.samba.org> <200212201829.18430.tomlins@cam.org> <20021221142226.GA24941@suse.de> <200212212341.29560.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212212341.29560.tomlins@cam.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2002 at 11:41:29PM -0500, Ed Tomlinson wrote:
 > 
 > Now for something new.  With bk current (6pm EST) I get:
 > Dec 21 23:30:56 oscar kernel: Call Trace:
 > Dec 21 23:30:56 oscar kernel:  [<e0de9108>] agp_backend_initialize+0x1c/0x168 [agpgart]
 > Dec 21 23:30:56 oscar kernel:  [<e0de92f8>] agp_register_driver+0x2c/0xac [agpgart]

I already fixed a bug with the same call-trace. This looks like
you've still got old .o files around. Can you make clean and rebuild
just to make sure ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
