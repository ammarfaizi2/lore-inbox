Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264262AbUFSQuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbUFSQuD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUFSQth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:49:37 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:1965 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S264262AbUFSQfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:35:22 -0400
Message-ID: <40D46B97.B82A439E@users.sourceforge.net>
Date: Sat, 19 Jun 2004 19:36:39 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: 4Front Technologies <dev@opensound.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com> <20040618204655.GA4441@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> It looks like SuSE as the first distribution took the sane approach to
> seperate source and output files.

Splitting source and object directories is indeed sane. But SUSE
implementation broke the 'build' symlink which has been the recommended way
for a long time to get to the main kernel Makefile directory.

> I presume they have documented this somewhere - and I have a patch
> from Andreas G. that should actually solve this if a module is
> compiled in the usual way like you do.

I have asked you n times to refrain from merging the 'build' symlink
breakage. I ask you again to not merge that breakage.

Please merge the 'object' symlink version instead.

> So you seems to be bitten by a distributor starting to use a new
> facility in kbuild.

SUSE folks made a silly mistake and broke stuff. It was even more silly for
them to try to submit that breakage to mainline.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
