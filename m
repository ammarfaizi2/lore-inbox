Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314214AbSDRBW3>; Wed, 17 Apr 2002 21:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314215AbSDRBW2>; Wed, 17 Apr 2002 21:22:28 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:30470 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314214AbSDRBW1>;
	Wed, 17 Apr 2002 21:22:27 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Martin Rode <martin.rode@programmfabrik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Callbacks to userspace from VFS ? 
In-Reply-To: Your message of "17 Apr 2002 16:21:13 +0200."
             <1019053273.8655.109.camel@marge> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Apr 2002 11:22:15 +1000
Message-ID: <30229.1019092935@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Apr 2002 16:21:13 +0200, 
Martin Rode <martin.rode@programmfabrik.de> wrote:
>after programming at least 10 scripts polling a what we call
>"hot-folder" for new files I had the idea to integrate call backs into
>the file system layer of the linux kernel.
>
>I would like to tell the kernel to callback my program whenever a file
>or directory is being inserted, updated or deleted.

dnotify already exists, although you have to work out what has changed.

XFS implements DMAPI (Data Management API) event callouts which give
much more details.  DMAPI is designed for full blown Hierarchical
Storage Managements systems.
http://www.opengroup.org/pubs/catalog/c429.htm to purchase the DMAPI
standard, there is also a free (with registration) online standard.

Not speaking for SGI.

