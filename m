Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSGYSQK>; Thu, 25 Jul 2002 14:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSGYSQK>; Thu, 25 Jul 2002 14:16:10 -0400
Received: from codepoet.org ([166.70.99.138]:57255 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315503AbSGYSQK>;
	Thu, 25 Jul 2002 14:16:10 -0400
Date: Thu, 25 Jul 2002 12:19:24 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: Header files and the kernel ABI
Message-ID: <20020725181923.GA4858@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oliver Xymoron <oxymoron@waste.org>,
	Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207251127150.17906-100000@waste.org> <3D4027DB.3090805@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4027DB.3090805@zytor.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jul 25, 2002 at 09:31:23AM -0700, H. Peter Anvin wrote:
> Oliver Xymoron wrote:
> >
> >Ideally, the ABI layer would be maintained and packaged separately from
> >both the kernel and glibc to avoid gratuitous changes from either side.
> >
> 
> I disagree.  The ABI is a product of the kernel and should be attached 
> to it.  It is *not* a product of glibc -- glibc is a consumer of it, as 
> are any other libcs.

Agreed.  I maintain a libc and I certainly do not want to 
have to maintain the kernel ABI of the day headers.  That
is clearly a job for the kernel.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
