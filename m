Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSHGUk6>; Wed, 7 Aug 2002 16:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSHGUk6>; Wed, 7 Aug 2002 16:40:58 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:44284 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S293680AbSHGUk5>; Wed, 7 Aug 2002 16:40:57 -0400
Subject: Re: 2.4.19 crash
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michal Illich <michal@illich.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D516428.5070005@illich.cz>
References: <3D516428.5070005@illich.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 23:04:06 +0100
Message-Id: <1028757846.26991.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 19:17, Michal Illich wrote:
> 	I want to report multiple crashes while using last stable kernel, the message 
> it gives is:
> 
> --------------------
> Unable to handle kernel paging request at virtual address 45ca6234
>   printing eip:

See REPORTING-BUGS in the kernel source tree, and run the first oops it
logged through the ksymoops tool. That'll make it a lot easier to see
what happened.

