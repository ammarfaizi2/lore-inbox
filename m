Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVJaJNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVJaJNq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVJaJNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:13:46 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:63412 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S932319AbVJaJNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:13:45 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Junio C Hamano <junkio@cox.net>
Cc: linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vpspmhxhz.fsf@assigned-by-dhcp.cox.net>
References: <20051029182228.GA14495@havoc.gtf.org><200510301731.47825.rob@landley.net><Pine.LNX.4.64.0510301654310.27915@g5.osdl.org><200510302035.26523.rob@landley.net><7v7jbujfh6.fsf@assigned-by-dhcp.cox.net><20051029182228.GA14495@havoc.gtf.org><200510301731.47825.rob@landley.net><Pine.LNX.4.64.0510301654310.27915@g5.osdl.org><200510302035.26523.rob@landley.net><7v7jbujfh6.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.62.0510302353370.16065@qynat.qvtvafvgr.pbz> <7vpspmhxhz.fsf@assigned-by-dhcp.cox.net>
Date: Mon, 31 Oct 2005 01:13:18 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [git patches] 2.6.x libata updates
In-Reply-To: <7vpspmhxhz.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.62.0510310109250.16065@qynat.qvtvafvgr.pbz>
References: <20051029182228.GA14495@havoc.gtf.org><200510301731.47825.rob@landley.net><Pine.LNX.4.64.0510301654310.27915@g5.osdl.org><200510302035.26523.rob@landley.net><7v7jbujfh6.fsf@assigned-by-dhcp.cox.net><20051029182228.GA14495@havoc.gtf.org><200510301731.47825.rob@landley.net><Pine.LNX.4.64.0510301654310.27915@g5.osdl.org><200510302035.26523.rob@landley.net><7v7jbujfh6.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.62.0510302353370.16065@qynat.qvtvafvgr.pbz>
 <7vpspmhxhz.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Junio C Hamano wrote:

> David Lang <david.lang@digitalinsight.com> writes:
>
>> given the time required to compile a kernel and reboot you can't plan to
>> keep the info server side (browser connections will time out well before
>> this finishes)
>>
>> instead this will require saving something on the client and passing it
>> back to the server.
>
> I was thinking about doing thatn in hidden input fields and
> passing form back and forth.  After all what real git bisect
> keeps locally are one bad commit ID and bunch of good commit
> IDs.

if it's kept in a file or cookie then it can survive a reboot and other 
distractions (remember that this process can take days if the problem 
doesn't show up at boot). a cookie can hold a couple K worth of data, a 
file has no size limit.

it would also be a good idea if the web page could give an estimate 
estimate of how many additional tests may end up being required.

David Lang
-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
