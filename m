Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSFDMK2>; Tue, 4 Jun 2002 08:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317484AbSFDMK1>; Tue, 4 Jun 2002 08:10:27 -0400
Received: from mons.uio.no ([129.240.130.14]:48884 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316595AbSFDMK0>;
	Tue, 4 Jun 2002 08:10:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [2.5.20-BUG] 3c59x + highmem + acpi + nfs -> kernel panic
Date: Tue, 4 Jun 2002 14:10:11 +0200
User-Agent: KMail/1.4.1
Cc: akpm@zip.com.au, aia21@cantab.net, linux-kernel@vger.kernel.org
In-Reply-To: <shshekkbnrr.fsf@charged.uio.no> <200206041339.32899.trond.myklebust@fys.uio.no> <20020604.033903.42777297.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206041410.11333.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 June 2002 12:39, David S. Miller wrote:
> Any sort of interrupt whatsoever would be enough to cause a problem
> here.  It is enough of a condition to allow the sunrpc code to
> run.

Duh. Of course you are right...

...and that alone suffices to justify the patch.

Cheers,
  Trond
