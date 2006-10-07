Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWJGIa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWJGIa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 04:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWJGIa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 04:30:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:15891 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750779AbWJGIa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 04:30:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ui2L6Hmd7FzYf83PA/mQrPT7MsxWWI51Bdgb9WCHV3jdhbIfRkZ+UTpWyQTZb814k+DuMIWovkOBnFDvrcyckgKptnYxEhyFkz0m8SEihrzVdPTCYF+NTlLj3m4PBvSXX8td733OXtun/anl96vT2bQ4TC4UD8rs3IJ0ihVpQyI=
Message-ID: <452765B4.7050303@gmail.com>
Date: Sat, 07 Oct 2006 10:30:21 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       p.hardwick@option.com
Subject: Re: [PATCH 1/2] Char: nozomi, Lindent the code
References: <54335498213213@wsc.cz> <20061006193955.207674da.akpm@osdl.org> <20061007055122.GA22518@kroah.com>
In-Reply-To: <20061007055122.GA22518@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Oct 06, 2006 at 07:39:55PM -0700, Andrew Morton wrote:
>> On Sat,  7 Oct 2006 01:53:58 +0200 (CEST)
>> Jiri Slaby <jirislaby@gmail.com> wrote:
>>
>>> [on the top of nozomi-use-tty-wakeup]
>>>
>>> nozomi, Lindent the code
>>>
>>> Use script/Lindent to indent nozomi driver.
>>>
>>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>>>
>>> ---
>>> commit e7e58c9f0d3ce7bed7f8c4b1921da37d65e3ee8f
>>> tree c0021b53033d27540ed9211a85905ae36ce5668e
>>> parent b19884f570ea41ff9100cc56962e8d6f435e2337
>>> author Jiri Slaby <jirislaby@gmail.com> Sat, 07 Oct 2006 01:47:22 +0200
>>> committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 07 Oct 2006 01:47:22 +0200
>>>
>>>  drivers/char/nozomi.c | 2759 ++++++++++++++++++++++++++-----------------------
>>>  1 files changed, 1446 insertions(+), 1313 deletions(-)
>> eep, this is all too hard while it's in Greg's tree.
>>
>> Greg: run Lindent ;)
> 
> Ok, now done, sorry about that.
> 
> Jiri, don't worry about the c++ comments right now, there are worse
> issues with this driver at the moment...
> 
> I'll fix them all up before this driver goes into the tree.

Aah, Ok :).

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
