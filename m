Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWHHFNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWHHFNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 01:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWHHFNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 01:13:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37935 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751237AbWHHFNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 01:13:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R2vJhVHqPdr1g5ut49touDe/hFsecY1IL9bt9kU4YlNkiFH9qzmAFzlHtH4/KM6i3Fyif+B/9aoy4XfIfOFNXRfAPb20kw0yfQDjb0oSlYRD2OWTpwsmf6KMXDaYHxETzHbTkjoBh/40Z4oeVMx8/ZqwUO0f8wFDYuKV6Q9F4b4=
Message-ID: <292693080608072213n2be75176g46199e92d669f5de@mail.gmail.com>
Date: Tue, 8 Aug 2006 10:43:13 +0530
From: "Daniel Rodrick" <daniel.rodrick@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
Cc: "Linux Newbie" <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44D76F26.9@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>
	 <44D7579D.1040303@zytor.com>
	 <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com>
	 <44D76F26.9@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > I'm sure having a single driver for all the NICs is a feature cool
> > enough to die for. Yes, it might have drawbacks like just pointed out
> > by Peter, but surely a "single driver for all NIC" feature could prove
> > to be great in some systems.
> >
>
> Assuming it works, which is questionable in my opinion.
>
> > But since it does not already exist in the kernel, there must be some
> > technical feasibility isse. Any ideas on this?
>
> No, that's not the reason.  The Intel code was ugly, and the limitations
> made other people not want to spend any time hacking on it.
>

Hi ... so there seem to be no technical feasibily issues, just
reliabliy / ugly design issues? So one can still go ahead and write a
Universal Protocol Driver that can work with all (PXE compatible)
NICs?

Are there any issues related to real mode / protected mode?

Thanks,

Dan
