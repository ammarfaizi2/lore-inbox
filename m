Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293509AbSCERIB>; Tue, 5 Mar 2002 12:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293520AbSCERHx>; Tue, 5 Mar 2002 12:07:53 -0500
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:46253 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S293509AbSCERHm>; Tue, 5 Mar 2002 12:07:42 -0500
Date: Tue, 05 Mar 2002 12:06:43 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Oliver.Schersand@BASF-IT-Services.com
cc: Alessandro Suardi <alessandro.suardi@oracle.com>, use-oracle@suse.com,
        suse-linux-e@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Antwort: Re: Kernel Hangs 2.4.16 on heay io Oracle and Tivolie TSM
Message-ID: <322850000.1015348003@tiny>
In-Reply-To: <3C838DA7.4050807@namesys.com>
In-Reply-To: <OFE7517866.AA039B23-ONC1256B72.0027B52F@bcs.de> <3C838DA7.4050807@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, March 04, 2002 06:07:19 PM +0300 Hans Reiser <reiser@namesys.com> wrote:


> Wasn't 2.4.16 the known unstable vm release of 2.4?  Why do you go to 
> such effort to stick with a bad kernel?  Go to 2.4.18.

I'm not sure exactly which vm problems you mean, but He's running the 
suse 2.4.16, which is heavily patched. When your running big production
databases, upgrading to the kernel of the week isn't an option.

I think we've found the bug, it looks like a race in the proc code.

Oliver, someone will contact you a little later with instructions on
getting a kernel with the fix.  If you only see this oops during backups,
make sure you aren't trying to backup /proc.

-chris

