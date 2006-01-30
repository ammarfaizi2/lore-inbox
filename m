Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWA3S7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWA3S7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWA3S7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:59:35 -0500
Received: from web50112.mail.yahoo.com ([206.190.39.149]:35763 "HELO
	web50112.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964875AbWA3S7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:59:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZTDKkbMwCWwzxCN858RtsAsh4HvWnYTFaJTvDTQPV4HG+tXYWXvPbLwYDAtpvELauHmpHyO0Dr7B8YuRcjAhRdDrnRfc5icuRggJkUmSZeDfXwKZ/zQhx+LeBgDeZQauB/6ha7CemMieL5NtMS1Aw3WrG1BQq70/oDzcP53b6SY=  ;
Message-ID: <20060130185931.71975.qmail@web50112.mail.yahoo.com>
Date: Mon, 30 Jan 2006 10:59:31 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: noisy edac
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@redhat.com>,
       "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060129234213.GA20133@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

that driver should be refactored to only output NON-FATALs with debug turned on. 

Copying to edac/bluesmoke mailing list

doug t

--- Dave Jones <davej@redhat.com> wrote:

> On Sun, Jan 29, 2006 at 04:52:06PM -0500, Alan Cox wrote:
>  > On Thu, Jan 26, 2006 at 08:41:05PM -0500, Dave Jones wrote:
>  > > e752x_edac is very noisy on my PCIE system..
>  > > my dmesg is filled with these...
>  > > 
>  > > [91671.488379] Non-Fatal Error PCI Express B
>  > > [91671.492468] Non-Fatal Error PCI Express B
>  > > [91901.100576] Non-Fatal Error PCI Express B
>  > > [91901.104675] Non-Fatal Error PCI Express B
>  > 
>  > Pre-production system or final release ?
> 
> Currently shipping Dell Precision 470.
> 
> 		Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

