Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264019AbUD0Lx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUD0Lx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 07:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUD0Lx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 07:53:59 -0400
Received: from mail.turbolinux.co.jp ([210.171.55.67]:37892 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id S264022AbUD0Lxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 07:53:52 -0400
Message-ID: <408E49B9.3090302@turbolinux.co.jp>
Date: Tue, 27 Apr 2004 20:53:29 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
Organization: Turbolinx Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.2.1) Gecko/20030105
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org
CC: Clemens Schwaighofer <cs@tequila.co.jp>, dlang@digitalinsight.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc2-mm2 + Adaptec I2O
References: <408DE95F.5010201@tequila.co.jp>	<20040426221814.490a0cfd.akpm@osdl.org>	<Pine.LNX.4.58.0404262223260.17702@dlang.diginsite.com>	<408DF117.4060309@tequila.co.jp>	<20040426230455.53406d74.akpm@osdl.org>	<408DFBEE.3080803@tequila.co.jp> <20040426232522.253594a2.akpm@osdl.org>
In-Reply-To: <20040426232522.253594a2.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> Clemens Schwaighofer <cs@tequila.co.jp> wrote:
> 
>>Andrew Morton wrote:
>> | Clemens Schwaighofer <cs@tequila.co.jp> wrote:
>> |
>> |> on this URL [http://www.smartcgi.com/?action=docs,kernel26-adaptec] you
>> |> can find a patch that I could successfully path again 2.6.5 (vanilla)
>> |> and compile successfully.
>> |
>> |
>> | hm.  Against 2.6.0.  Go, would you have time to send that patch in to the
>> | scsi team at linux-scsi@vger.kernel.org?
>>
>> yes,
>>
>> remark:
>>
>> ~ Originally this patch has been released by Go Taniguchi at
>> http://pkgcvs.turbolinux.co.jp/~go/patch-2.6/dpt_i2o.patch
>>
>> patch attached
> 
> 
> Sorry, my question was directed to Go Taniguchi <go@turbolinux.co.jp> - Go
> should submit the patch.

Yea, I sent an mail to LKML in the end of last year regarding this issue.
http://marc.theaimsgroup.com/?l=linux-kernel&m=107275564119915&w=2

However, I think that Adaptec probably just re-make a new version of dpt_i2o.
My patch may differ from the Adaptec policy.

I thought that it may be good for someone need the driver before Adaptec 
completed the driver. What's why I uploaded my patch onto web.

The number of the access is over 1000 now after I counted it.

Please merge to Andrew's tree if Adaptec does not mind.

This is my patch same as send from Clemens.
http://pkgcvs.turbolinux.co.jp/~go/patch-2.6/dpt_i2o.patch


