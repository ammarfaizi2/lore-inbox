Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSJCO2c>; Thu, 3 Oct 2002 10:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSJCO2c>; Thu, 3 Oct 2002 10:28:32 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:23820 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261506AbSJCO2a>; Thu, 3 Oct 2002 10:28:30 -0400
Date: Thu, 3 Oct 2002 15:32:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kevin Corry <corryk@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
Message-ID: <20021003153256.B17513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kevin Corry <corryk@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02100216332002.18102@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02100216332002.18102@boiler>; from corryk@us.ibm.com on Wed, Oct 02, 2002 at 04:33:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 04:33:20PM -0500, Kevin Corry wrote:
> EVMS provides a new, stand-alone subsystem to the kernel

i.e. it duplictes existing block layer/volume managment functionality..

> subdirectories were created: drivers/evms/ for the main source code,
> and include/linux/evms/ for the header files. 

What's the reason to not have the headers under drivers/evms.  And why
don'T you just use drivers-md like all other volume managment drivers?

> - Add a table entry and a short function to init/do_mounts.c to
>   allow an EVMS volume to be specified as the root filesystem with
>   the kernel command line option "root="

Could you explain the details of how this works?

> version of EVMS was released. EVMS has been accepted into the
> Debian (Woody and Sid versions)

Can't find evms in my stock woody or sid kernel images.. (neither in the
sarge ones, btw..)

> and UnitedLinux distributions,

UL has so far merged everything IBM sent them..


It would be nice if you could attach the code you want merged,
otherwise it's pretty hards to review it
