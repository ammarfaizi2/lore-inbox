Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSLRQWd>; Wed, 18 Dec 2002 11:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSLRQWd>; Wed, 18 Dec 2002 11:22:33 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:26011 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S263326AbSLRQWd>;
	Wed, 18 Dec 2002 11:22:33 -0500
Date: Wed, 18 Dec 2002 16:29:58 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Message-ID: <20021218162958.GA27695@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ed Tomlinson <tomlins@cam.org>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20021218094714.43C712C076@lists.samba.org> <200212180757.53583.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212180757.53583.tomlins@cam.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 07:57:53AM -0500, Ed Tomlinson wrote:
 > > >  > Ed, does it work if you take all the __init out of the agp code?
 > > > My moneys on it working. The oops looked like it was jumping to oblivion
 > > > when it called agp_backend_initialize.
 > Dave when you have this in a bk tree let me know and I will pull and 
 > verify it working here.

bk://linux-dj.bkbits.net/agpgart

I've given it a compile testing, but not booted it yet.
Scream if necessary.

	Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
