Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbSKUCCv>; Wed, 20 Nov 2002 21:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266278AbSKUCCv>; Wed, 20 Nov 2002 21:02:51 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:11278 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266271AbSKUCCv>; Wed, 20 Nov 2002 21:02:51 -0500
Date: Thu, 21 Nov 2002 02:09:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] export e820 table on x86
Message-ID: <20021121020953.A13644@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DDC3E43.2080302@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DDC3E43.2080302@us.ibm.com>; from haveblue@us.ibm.com on Wed, Nov 20, 2002 at 06:00:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 06:00:35PM -0800, Dave Hansen wrote:
> I stole a patch that Arjan did a while ago, and ported it up to 2.5:
> http://www.kernelnewbies.org/kernels/rh80/SOURCES/linux-2.4.0-e820.patch
> 
> We need this so avoid making BIOS calls when using kexec.

It should at least use seq_file, and I'm not sure whether it wouldn't
better fit into sysfs (don't ask me where exactly :))

