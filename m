Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTDEEj7 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 23:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbTDEEj7 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 23:39:59 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:9735 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S261798AbTDEEj5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 23:39:57 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Ed Vance <EdV@macrolink.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail 
In-reply-to: Your message of "Fri, 04 Apr 2003 16:38:50 PST."
             <11E89240C407D311958800A0C9ACF7D1A33E27@EXCHANGE> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 Apr 2003 14:51:16 +1000
Message-ID: <30498.1049518276@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003 16:38:50 -0800 , 
Ed Vance <EdV@macrolink.com> wrote:
>On Fri, Apr 04, 2003 at 3:21 PM, Keith Owens wrote:
>> 
>> On Fri, 4 Apr 2003 14:10:16 -0800 , 
>> Ed Vance <EdV@macrolink.com> wrote:
>> >Perhaps there is a middle ground. Leave the list open, but require a
>> >confirmation reply prior to passing along posts from addresses that:
>> >
>> >1. are not members of the list, AND
>> >2. have not previously done a proper confirmation reply.
>> 
>> 30 seconds after doing that, the spammers will forge email that claims
>> to be from LT, AC, DM, MT etc.  Not to mention all the viruses that
>> forge the headers.  Verification by 'From:' line on an open list is
>> pointless.
>> 
>The goal was to greatly reduce, in one swell foop, the volume of spam that
>the filters (and postmaster) must interactively deal with. I thought that
>perhaps this method could replace one of more of the troublesome filtering
>techniques to achieve the same net spam reduction without evoking as much
>whining.

Paraphrase: Replace filtering code that catches spam with filtering
code based on checking header content that can be trivially forged by
spammers.

>Matti, 
>Roughly what percentage of the spam actually hitting vger today (and
>bouncing off) is based on Keith's flavor of spoofing? Is it even 1 percent? 

Current figures are irrelevant, spammers react to spam filters and they
react very quickly[*].  If you replace "reject HTML bodies" with "allow
HTML based on known From: lines" then the spammers will send HTML
bodies with forged headers, because they know it will get through.
That will require the original HTML filters to be reintroduced, the end
result is you added an extra step for new posters without reducing the
spam or users whining "my mail does not get through".

[*] About 24 hours after slashdot carried a story on Baysian spam
    filters, I started receiving HTML spam that contained comments that
    were designed to fool the Baysian filters, like this.

    FREE 1 MONTH SUPP<!--kernel-->Y WITH THIS

    The comment has no effect on the spam display but the use of
    non-spam words skews the Baysian rules on whether the content is
    spam or not.

