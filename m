Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWFKFR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWFKFR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 01:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbWFKFR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 01:17:29 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:41155 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1161079AbWFKFR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 01:17:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=X0Ie9z/T3/gM6Oo2HTRyvDBKlnwfqwdmLRmfmNNHsPvgwhEZ1aEsi7ZzlpdHSE3+;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <193701c68d16$54cac690$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Date: Sat, 10 Jun 2006 22:17:26 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120b4d35498f734f7ad5a72d0288f62def6a30146a21c727840350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.167.175
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David Schwartz" <davids@webmaster.com>

>> Rather than inject emotions let's play a little bit with facts. This is
>> excerpts from a SpamAssassin report for about 82000 emails.
>>
>> TOP SPAM RULES FIRED
>> ------------------------------------------------------------
>> RANK    RULE NAME              COUNT %OFRULES %OFMAIL %OFSPAM  %OFHAM
>> ------------------------------------------------------------
>>   49    SPF_SOFTFAIL           1804     0.42    2.20    8.31    0.01
>>   72    SPF_HELO_PASS          1112     0.26    1.36    5.13   47.45
>>   78    SPF_PASS                994     0.23    1.21    4.58   45.53
>>   92    SPF_HELO_SOFTFAIL       772     0.18    0.94    3.56    0.03
>>  113    SPF_FAIL                589     0.14    0.72    2.71    0.00
>>  177    SPF_HELO_FAIL           352     0.08    0.43    1.62    0.00
>>
>> Stated from the opposite view
>>
>> TOP HAM RULES FIRED
>> ------------------------------------------------------------
>> RANK    RULE NAME              COUNT %OFRULES %OFMAIL %OFSPAM  %OFHAM
>> ------------------------------------------------------------
>>    5    SPF_HELO_PASS          28563     7.20   34.88    5.13   47.45
>>    6    SPF_PASS               27409     6.90   33.47    4.58   45.53
>>
>> And so forth.
>>
>> People here should be smart enough to draw their own conclusions from
>> raw data.
> 
> Yeah, that you measured the wrong thing. SPF does not distinguish spam from
> non-spam.
> 
> What percentage of emails with forged sender addresses passed an SPF check?
> What percentage of emails with forged sender addresses failed an SPF check?
> What percentage of emails that correctly identified their senders passed an
> SPF check? What percentage of emails that correctly identified their senders
> failed an SPF check?
> 
> SPF is an anti-forgery tool. It helps to prevent joe-jobs and false claims
> of being the victim of a joe-job.

I'll add to my offlist reply - SPF can be forged, as I noted. And it
really does not matter at all if you have a good or bad SPF record. It
does not tell you whether or not a message is to be accepted or rejected,
has bountiful information content or is a troll, or anything else for
that matter. It simply says, "When I went and looked at the guy's claimed
mail source the spf record said he was who he said he was." Who vouches
for the spf record? It seems tautological for me to stand before you
ladies and gentlemen here and ingenuously proclaim that I am who I
proclaim I am because I have vouched for myself with an spf record
I created for myself. This is what spammers did for awhile. That has
dropped off because it didn't help them and didn't much hurt them
either.

This is a LONG AGO dead discussion on the SpamAssassin user's list.
Those arguing about this issue should dig through the old message
archives on the list.

It is probably a good thing for VGER to vouch for its own mailing.
It is not much of a good thing for VGER to do anything else about SPF.

{^_^}   Joanne Dow said that.
