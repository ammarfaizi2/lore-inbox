Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbVIIUM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbVIIUM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbVIIUM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:12:26 -0400
Received: from magic.adaptec.com ([216.52.22.17]:33487 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030444AbVIIUMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:12:23 -0400
Message-ID: <4321ECA1.9050702@adaptec.com>
Date: Fri, 09 Sep 2005 16:12:17 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.6.13 1/20] aic94xx: Makefile
References: <4321E335.5010805@adaptec.com> <20050909201834.GA24521@mipter.zuzino.mipt.ru>
In-Reply-To: <20050909201834.GA24521@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 20:12:22.0400 (UTC) FILETIME=[C9AB2000:01C5B57A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/05 16:18, Alexey Dobriyan wrote:
> On Fri, Sep 09, 2005 at 03:32:05PM -0400, Luben Tuikov wrote:
> 
>>--- linux-2.6.13-orig/drivers/scsi/aic94xx/Makefile
>>+++ linux-2.6.13/drivers/scsi/aic94xx/Makefile
> 
> 
>>+CHECK = sparse -Wbitwise
> 
> 
> 	make C=1 CHECK="sparse -Wbitwise"
> or
> 	make C=1
> 
> 
>>+clean-files += *~
> 
> 
> Don't override what other people want.

Ok, will do.

	Luben

