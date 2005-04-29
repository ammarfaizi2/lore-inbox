Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVD2JSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVD2JSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 05:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVD2JSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 05:18:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:35471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262111AbVD2JSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 05:18:39 -0400
Date: Fri, 29 Apr 2005 02:17:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org, "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6 upgrade overall failure report
Message-Id: <20050429021756.7bd5535f.akpm@osdl.org>
In-Reply-To: <055FPDS12@server5.heliogroup.fr>
References: <055FPDS12@server5.heliogroup.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau <hubert.tonneau@fullpliant.org> wrote:
>
> Right from the beginning, the core 2.6 kernel was rock solid for me, so I had
>  no crash to complain, but ...
> 
>  . I reported a year ago that SCSI fusion was unable to properly recover from
>    tiny errors under 2.6 as opposed to 2.4 ... and got hit by the same problem
>    6 monthes later

Please send a full report to Eric Moore and cc linux-scsi@vger.kernel.org

>  . There is still a memory leak trouble (probably in tigon3 driver since others
>    reported so on kernel mailing list, and tigon3 is not a geek hardware since
>    most nowdays lowend servers use either tigon3 or pro1000)

Please send a report to David Miller and Jeff Garzik and cc netdev@oss.sgi.com

>  . There have been USB storage issues, also they are now solved

OK.

>  . Since 2.6.10, the TCP task does not work anymore with OSX (2 Mbps instead
>    of 60 Mbps on a 100 Mbps wire)

Please send a full report to David Miller and cc netdev@oss.sgi.com.

Also please describe a simple way of reproducing this - I'll see if it
happens here.

> the 2.6 development model

Is dependent upon the quality and promptness of reports from testers such
as yourself, as well as the testers' preparedness to respond to the
developers' questions.

Thanks.

