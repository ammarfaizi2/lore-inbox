Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313225AbSC1TD6>; Thu, 28 Mar 2002 14:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313226AbSC1TDs>; Thu, 28 Mar 2002 14:03:48 -0500
Received: from ns.suse.de ([213.95.15.193]:9733 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313225AbSC1TDf>;
	Thu, 28 Mar 2002 14:03:35 -0500
Date: Thu, 28 Mar 2002 20:03:31 +0100
From: Dave Jones <davej@suse.de>
To: Bob Miller <rem@osdl.org>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.7-dj2] Compile Error
Message-ID: <20020328200331.B5064@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Bob Miller <rem@osdl.org>, Adam Kropelin <akropel1@rochester.rr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203281216.32590@xsebbi.de> <00c801c1d655$d8e75cd0$02c8a8c0@kroptech.com> <20020328095352.A6291@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 09:53:52AM -0800, Bob Miller wrote:
 > So if you build with CONFIG_BSD_PROCESS_ACCT not set you're build will
 > break.  I'm in the process of generating a patch that will make acct.c
 > again conditionally compile based on CONFIG_BSD_PROCESS_ACCT.  This
 > should be done in a little bit and I'll post.
 > 
 > Dave, where did you get the patch for acct.c?

Al Viro's 0-aliases-c-C7-pre2
It looks like killing the first occurance of acct.o in kernel/Makefile
should do the trick. Let me know if that works out.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
