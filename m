Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280769AbRKKBpu>; Sat, 10 Nov 2001 20:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280775AbRKKBpk>; Sat, 10 Nov 2001 20:45:40 -0500
Received: from oss.sgi.com ([216.32.174.27]:60079 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S280769AbRKKBpW>;
	Sat, 10 Nov 2001 20:45:22 -0500
Date: Sun, 11 Nov 2001 08:55:26 +1100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: __builtin_* functions
Message-ID: <20011111085526.A13304@dea.linux-mips.net>
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E4CA@axcs13.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E4CA@axcs13.cos.agilent.com>; from hiren_mehta@agilent.com on Thu, Nov 08, 2001 at 11:19:40AM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 11:19:40AM -0700, MEHTA,HIREN (A-SanJose,ex1) wrote:

> Can these __builtin_* functions provided by gcc be used inside kernel ?
> In particular __builtin_alloca ?

In theory they're usable, in practice you should consider that alloca will
allocate memory on the stack which is of very limited size under Linux so
alloca doesn't usually seem to be a good idea.

  Ralf
