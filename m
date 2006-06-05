Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751051AbWFEMfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWFEMfw (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWFEMfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:35:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:36077 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751051AbWFEMfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:35:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=So1MswUaTDuC/VQysB4Zpt4srUEMBHXNF4SQnAqQjap1Sei3wbSJ2hffvi9XX9Av+1ytxNBumKTjltXBNsTbnwDL0mlOcoWd97W/Wf+KoIyv7vTFWqXsw+qc9m8tYJRaP2TBbQaC4BgG0ESdwyP9WNMWC/+lnflP3a29zS1Xl9g=
Message-ID: <6bffcb0e0606050535l5773c29cpc1783f545636e05d@mail.gmail.com>
Date: Mon, 5 Jun 2006 14:35:51 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch, -rc5-mm3] fix IDE deadlock in error reporting code
Cc: "Andrew Morton" <akpm@osdl.org>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20060605122445.GA4769@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com>
	 <6bffcb0e0606040308j28d9e89axa0136908c5530ae3@mail.gmail.com>
	 <20060604104121.GA16117@elte.hu>
	 <6bffcb0e0606040407u4f56f7fdyf5ec479314afc082@mail.gmail.com>
	 <20060604213803.GC5898@elte.hu>
	 <6bffcb0e0606041535u10fdb7c2o9ac38d6fb80fd28d@mail.gmail.com>
	 <20060605083016.GA31013@elte.hu> <20060605083530.GA31738@elte.hu>
	 <6bffcb0e0606050433i1261d3e4sd0d958fb15208596@mail.gmail.com>
	 <20060605122445.GA4769@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > Hi,
[snip]
> > Probably fixed, thanks.
>
> could you send a confirmation if/when you have tried this? I dont get
> the same message (i have another IDE chipset).

I have tried to reproduce that bug, it seems that it's very hard to
reproduce. After 20 reboots with your patch I haven't seen that.

>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
