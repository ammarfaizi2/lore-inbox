Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbVHOFUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVHOFUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 01:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVHOFUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 01:20:09 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:60298 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S1751076AbVHOFUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 01:20:08 -0400
Date: Mon, 15 Aug 2005 10:51:07 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
cc: sumit kalra <i_am_sumit_kalra@yahoo.com>
Subject: Re: starting a user defined daemon at linux startup.
In-Reply-To: <20050814084810.22147.qmail@web61019.mail.yahoo.com>
Message-ID: <Pine.LNX.4.60.0508151049150.13101@lantana.cs.iitm.ernet.in>
References: <20050814084810.22147.qmail@web61019.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sumit, I did it in the same way as ur first solution.
it worked.

On Sun, 14 Aug 2005, sumit kalra wrote:

> Hi Manohar,
>
> Yes, you need to put a scripts in /etc/rc.d/init.d
> which would invoke your daemon. You should provide
> options in this script to start/stop this daemon and
> fetch it's status etc. Please look at any other script
> there - for example nfs. The daemon binary can be
> placed anywhere, say /usr/sbin or anywhere else. If
> you put this startup script in /etc/rc.d/init.d your
> daemon will be loaded at startup.
>
> Another thought on this one: If you put your commands
> in rc.sysinit, they are executed at startup so you can
> start your daemon from there as well. It should work
> but I don't think that is the correct way to do it.
>
> Regards,
> Sumit
>
> --- "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
> wrote:
>
>>
>> Hai
>>    I have written a daemon, and it is working when I
>> load it.
>>    Now I want to start that daemon at startup in
>> linux, so that without
>> manually running , it has to start along with all
>> the daemons available
>> in the system. I came to know that we need to put a
>> script into
>> /etc/rc.d/init.d/
>> similar to sshd or atd. Do we need to write a script
>> to run my daemon?
>>
>> I have the daemon's binary, what should be the
>> script content to run it .
>>
>> But my daemon is just a single executable, is there
>> any othr way to do
>> this.
>>
>> Thanks In Advance.
>> P.manohar.
>>
>>
>> -
>> To unsubscribe from this list: send the line
>> "unsubscribe linux-newbie" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at
>> http://www.linux-learn.org/faqs
>>
>
>
>
>
>
>
> ___________________________________________________________
> Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
>
