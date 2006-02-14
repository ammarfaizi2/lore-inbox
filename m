Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbWBNSMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbWBNSMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbWBNSMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:12:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:21225 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1422730AbWBNSMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:12:54 -0500
Message-ID: <43F21D84.8010907@zytor.com>
Date: Tue, 14 Feb 2006 10:12:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, drepper@redhat.com,
       austin-group-l@opengroup.org
Subject: Re: The naming of at()s is a difficult matter
References: <43EEACA7.5020109@zytor.com> <Pine.LNX.4.61.0602121137090.25363@yvahk01.tjqt.qr> <43F09320.nailKUSI1GXEI@burner> <Pine.LNX.4.61.0602140916440.7198@yvahk01.tjqt.qr> <43F1F2C2.nailMWZGOQDYR@burner> <Pine.LNX.4.61.0602141907030.32490@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602141907030.32490@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>>Do you have a better proposal for naming the interfaces?
>>>
>>>chownfn maybe. (fd + name)
>>
>>I am not shure if this would match the rules from the Opengroup.
>>Solaris has these interfaces since at least 5 years.
> 
> This is not the cdrecord thread so Solaris is a no-go in this very one.
> 

FWIW, I think the -at() suffix is just fine, and well established by now 
(yes, there is shmat, but the SysV shared memory interfaces are bizarre 
to begin with -- hence POSIX shared memory which has real names.)

What I object to is the random, meaningless and misleading application 
of the f- suffix.

	-hpa
