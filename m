Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752151AbWFLXEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbWFLXEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 19:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbWFLXE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 19:04:29 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:60851 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1752151AbWFLXE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 19:04:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=Kkl1X9CoNhSSw2x4dnFowTImu7dkxaxAOEVGjsLJmUkvi4da+3LIugSzCKUYpNce;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <027e01c68e74$76875910$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Jesper Juhl" <jesper.juhl@gmail.com>, <nick@linicks.net>
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Bernd Petrovitsch" <bernd@firmix.at>,
       "marty fouts" <mf.danger@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>,
       <linux-kernel@vger.kernel.org>
References: <bernd@firmix.at> <1150100843.26402.22.camel@tara.firmix.at> <200606122025.k5CKPTGB005597@laptop11.inf.utfsm.cl> <7c3341450606121410y7f2349e1y7d8ecf3f3873732@mail.gmail.com> <9a8748490606121506w43c8a45yf44d0c4120ae80c@mail.gmail.com>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Date: Mon, 12 Jun 2006 16:03:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120b56ff735b21b1800108951bae21f227194574176393afc6a350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.167.175
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jesper Juhl" <jesper.juhl@gmail.com>

> On 12/06/06, Nick Warne <nick.warne@gmail.com> wrote:
>> I have been following this closely, and without getting into the
>> discussion re SPF, I think one issue especially affecting LKML is the
>> traffic.
>>
>> One (almost sure) fire way to stop the spam is to make a subscribed
>> ML.  But people like myself cannot/have not the resource to take on
>> the 200+ mails a day (how the kernel devs manage it, I don't know?).
>>
>> So I have subscribed via my gmail account to follow the mails, but
>> then at least I can reply from my 'real address' and keep the thread
>> intact (if you see what I mean).
>>
>> So, why not make the list a subscribe only list to SEND, but give an
>> option to NOT receive any mail from the list unless CC'ed?
>>
> 
> Making subscription to LKML a requirement would be a major barier for
> people who just want to shoot off a bug report or similar but who do
> not want to be subscribed (nor can be botherd to go through the
> motions to subscribe, or perhaps can't work out how to subscribe)...
> We want users to be able to submit bugreports to the list easily.

Greylist those who have not subscribed. Let their email server try
again in 30 minutes. For those who are not subscribed it should not
matter if their message is delayed 30 minutes. And so far spammers
never try again. That's FAR more likely to nail spam than using SPF
as a singular measure. It doesn't even require the remote DNS
transaction to check an SPF record.

{^_^}   Joanne
