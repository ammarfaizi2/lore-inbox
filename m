Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUJODax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUJODax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 23:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUJODax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 23:30:53 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:25167 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266048AbUJODap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 23:30:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: William Wolf <wwolf@vt.edu>
Subject: Re: 2.6.9-rc4-mm1
Date: Thu, 14 Oct 2004 22:30:38 -0500
User-Agent: KMail/1.6.2
Cc: kernel list <linux-kernel@vger.kernel.org>, akpm@zip.com.au
References: <416EE7EB.4070209@vt.edu> <200410141815.03110.dtor_core@ameritech.net> <416F42A0.5060103@vt.edu>
In-Reply-To: <416F42A0.5060103@vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410142230.38633.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 October 2004 10:23 pm, William Wolf wrote:
> Dmitry Torokhov wrote:
> > On Thursday 14 October 2004 03:56 pm, William Wolf wrote:
> > 
> >>Hey, I just tried -rc4-mm1 on my amd64 laptop, and my keyboard fails to
> >>work, I don't even think it is being recognized. 
> > 
> > 
> > Could you try booting with i8042.noacpi and if it helps mailing me your
> > /proc/acpi/dsdt?
> > 
> > Thanks!
> > 
> 
> 
> Thanks a bunch, this fixed the keyboard problem.  What did this do 
> exactly?

It caused i8042 not to rely on ACPI BIOS data and use defaults.

/proc/acpi/dsdt, pretty please.

-- 
Dmitry
