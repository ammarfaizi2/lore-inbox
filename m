Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSKLPzA>; Tue, 12 Nov 2002 10:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSKLPzA>; Tue, 12 Nov 2002 10:55:00 -0500
Received: from borg.org ([208.218.135.231]:7142 "HELO borg.org")
	by vger.kernel.org with SMTP id <S261732AbSKLPy7>;
	Tue, 12 Nov 2002 10:54:59 -0500
Date: Tue, 12 Nov 2002 11:01:49 -0500
From: Kent Borg <kentborg@borg.org>
To: Adam Voigt <adam@cryptocomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
Message-ID: <20021112110149.A9492@borg.org>
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1037115535.1439.5.camel@beowulf.cryptocomm.com>; from adam@cryptocomm.com on Tue, Nov 12, 2002 at 10:38:55AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 10:38:55AM -0500, Adam Voigt wrote:
> I have a directory with 39,000 files in it, and I'm trying to use the cp
> command to copy them into another directory, 
> [...]
> "argument list too long"

No, it is not a kernel limit, it is a limit to your shell (bash, for
example).  Look at xargs to get around it.

A related limit is that the popular ext2 and 3 file systems get
inefficient when directories have so many files.  The work-around for
that is to have your files either hashed or organized across a
collection of directories.


-kb
