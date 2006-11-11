Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947099AbWKKEwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947099AbWKKEwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 23:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947102AbWKKEwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 23:52:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:36914 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1947099AbWKKEwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 23:52:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JEl7D0oOimBk+P5RfurT0lD9z3ByHVcajOH2k9kD818muTBYgVsyWNNjtg4CRl/NdODmOKUeRW39soUhwVdkEsE/YOn1bNzSugD1sh+NgVV0wGhsbNWhHJiDpvUXlMcqiV4LOTjmn/bZrgnWFHvp7iOweK9GVmHKM1DPfrtX6vs=
Message-ID: <455556F7.4000802@gmail.com>
Date: Sat, 11 Nov 2006 13:52:07 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Tomasz Chmielewski <mangoo@wpkg.org>, linux-kernel@vger.kernel.org,
       madduck@madduck.net
Subject: Re: scary messages: HSM violation during boot of 2.6.18/amd64
References: <455496CA.5040405@wpkg.org> <200611102239.kAAMdoYV015817@turing-police.cc.vt.edu>            <45550308.1090408@wpkg.org> <200611102310.kAANAgOf019164@turing-police.cc.vt.edu>
In-Reply-To: <200611102310.kAANAgOf019164@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 10 Nov 2006 23:54:00 +0100, Tomasz Chmielewski said:
> 
>> You use old smartmontools :)
>>
>> -o on / -S on is not supported for sata, unless you use a CVS version of 
>> smartmontools.
> 
> OK, thanks - the Fedora RPM from several days ago is still 5.36 based,
> I just pulled the CVS version and it starts up much more nicely.  Only quirk:
> 
> Nov 10 18:04:32 turing-police smartd[18988]: Device: /dev/sda, opened 
> Nov 10 18:04:32 turing-police smartd[18988]: Device /dev/sda: SATA disks accessed via libata are supported by Linux kernel versions 2.6.15-rc1 and above. Try adding '-d ata' or '-d sat' to the smartd.conf config file line. 
> 
> Well, yeah. I'm on 2.6.19-rc5-mm1 and the config file *has* '-d ata' already. ;)
> I'd file a bug report against that, except it's time for me to leave the office
> and forage for some dinner. :)

For detailed info,

http://thread.gmane.org/gmane.linux.ide/13222/focus=13235

-- 
tejun
