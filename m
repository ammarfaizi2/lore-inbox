Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbTEaUIf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 16:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTEaUIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 16:08:35 -0400
Received: from [62.29.78.7] ([62.29.78.7]:16257 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S264420AbTEaUIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 16:08:34 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Andrew Morton <akpm@digeo.com>
Subject: Re: About 2.5.70-mm3
Date: Sat, 31 May 2003 23:21:22 +0300
User-Agent: KMail/1.5.9
References: <200305311507.53284.kde@myrealbox.com> <20030531104443.63cb1445.akpm@digeo.com>
In-Reply-To: <20030531104443.63cb1445.akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305312321.22847.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 May 2003 20:44, you wrote:
> There's a little hack in there which speeds up the loading of executables:
> when someone does a mmap of a file with executable permissions the kernel
> will slurp it all into pagecache during the mmap.  That tends to speed up
> program loading quite a lot, because the normal demand-loading produces
> quite poor I/O patterns.
Cool

>
> I had a vague feeling that this code wasn't working actually, and
> reimplemented it for -mm4.
You do not really feel it in X but on system startup its *quite* impressive.


Regards,
/ismail
