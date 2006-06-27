Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWF0TSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWF0TSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWF0TS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:18:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:63983 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932545AbWF0TS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:18:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FuCAWS/Ffgeaj0k0aFShYwT4cSOxXDCGqwAGeGO/IL6Xp6nHrAA/Tjnqn06MkwaQCLbE+q9aUNQRLXvImp70Z4vQD/TrorKKWwQUKd9eyHD8kGwpK9lnCpnksCha6SfLh5WIBYzV3TF6dEs+/eiT6eDs5IC5opKVQKROaIGMiTM=
Message-ID: <cda58cb80606271218u2096a336pe87a8ec66a5a56cd@mail.gmail.com>
Date: Tue, 27 Jun 2006 21:18:27 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: [PATCH 1/7] bootmem: remove useless __init in header file
Cc: "Andrew Morton" <akpm@osdl.org>, "Mel Gorman" <mel@skynet.ie>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1151428620.24103.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <449FDD02.2090307@innova-card.com>
	 <1151344691.10877.44.camel@localhost.localdomain>
	 <44A12A43.3050501@innova-card.com>
	 <1151428620.24103.0.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/6/27, Dave Hansen <haveblue@us.ibm.com>:
> On Tue, 2006-06-27 at 14:53 +0200, Franck Bui-Huu wrote:
> > +extern void * __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
> > +extern void * __alloc_bootmem_nopanic (unsigned long size, unsigned long align, unsigned long goal);
>
> Since we're being picky about kernel coding style, doesn't the '*' go
> next to the function name? ;)
>

yeah, I noticed that but I wouldn't be too paranoid. But since you ask
for, I'll do that too :)

thanks
-- 
               Franck
