Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277012AbRKMRLD>; Tue, 13 Nov 2001 12:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277024AbRKMRKx>; Tue, 13 Nov 2001 12:10:53 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:12224 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277012AbRKMRKq>;
	Tue, 13 Nov 2001 12:10:46 -0500
Date: Tue, 13 Nov 2001 17:10:37 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Changed message for GPLONLY symbols
Message-ID: <2349543194.1005671437@[10.132.113.67]>
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

--On Tuesday, November 13, 2001 1:50 PM +1100 Keith Owens <kaos@ocs.com.au> 
wrote:

> Hint: You are trying to load a module without a GPL compatible license
>       and it has unresolved symbols.  The module may be trying to access
>       GPLONLY symbols but the problem is more likely to be a coding or
>       user error.  Contact the module supplier for assistance.
>
> Does anyone think that this message can be misunderstood by anybody
> with the "intelligence" of the normal Windoze user?

Yes I think it can be misunderstood, and, perhaps more importantly, still
points the user at GPLONLY when it's more likely to be a straightforward
version mismatch. Better might be:

Hint: You are trying to load a module which has unresolved symbols. These
      symbols may not be exported by this version of the kernel (perhaps
      you have a version mismatch), or they may be exported GPLONLY,
      (in which case they will not be available to your module which does
      not carry a GPL compatible license). In either case, contact
      the module supplier for assistance.

--
Alex Bligh
