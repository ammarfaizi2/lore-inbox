Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWDDK4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWDDK4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 06:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWDDK4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 06:56:24 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:47561 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751853AbWDDK4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 06:56:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sHIoBZIEdwdGdwN2APiF6kEjnFS2y2TY0EdmVwnUaPAFsibIYfZIobep69r9ylgXMMTAkomIzyXVHoZLQ8Qpt+mA+4dc7RLUozZGIKsivy/6um19ygCI7cbUCl8Wt3DRpc0VBshfv20toDg1FitCHff275qSZR+pCpUEJvsvuuo=
Message-ID: <443250D1.3020403@gmail.com>
Date: Tue, 04 Apr 2006 19:56:17 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Mauro Tassinari <mtassinari@cmanet.it>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: libata/sata status on ich[?]
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAyTp2U2YnGEW3ub1INE9nAAEAAAAA@cmanet.it> <44323C24.4010402@garzik.org> <44323DE9.7030106@gmail.com> <443241F4.7080801@garzik.org>
In-Reply-To: <443241F4.7080801@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> This should be fixed by the ata_piix map patch I've submitted and is 
>> currently in #upstream. [ P0 P1 P2 P3 ] should be [ P0 P2 P1 P3 ].
> 
> If you are referring to this fix:
> 
>> commit 79ea24e72e59b5f0951483cc4f357afe9bf7ff89
>> Author: Tejun Heo <htejun@gmail.com>
>> Date:   Fri Mar 31 20:01:50 2006 +0900
>>
>>     [PATCH] ata_piix: fix ich6/m_map_db
> 
> then its already in linux-2.6.git, and 2.6.17-rc1.
> 

Yeap, that one.  I'm very sure 2.6.17-rc1 fixes the problem then.

-- 
tejun
