Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWJBRe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWJBRe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWJBRe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:34:26 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:23751 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965163AbWJBReZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:34:25 -0400
Date: Mon, 2 Oct 2006 10:19:00 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
In-Reply-To: <1159811392.8907.36.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0610021017310.28876@qynat.qvtvafvgr.pbz>
References: <1159539793.7086.91.camel@mindpipe>  <20061002100302.GS16047@mea-ext.zmailer.org>
  <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org> 
 <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org> <1159811392.8907.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006, Alan Cox wrote:

> Ar Llu, 2006-10-02 am 09:40 -0700, ysgrifennodd Linus Torvalds:
>> If you want a yes/no kind of thing, do it on real hard issues, like not
>> accepting email from machines that aren't registered MX gateways. Sure,
>> that will mean that people who just set up their local sendmail thing and
>> connect directly to port 25 will just not be able to email, but let's face
>> it, that's why we have ISP's and DNS in the first place.
>
> Except most of the ISPs are incompetent and many people have to run
> their own mail system in order to get mail that actually *works*. I've
> had that experience several times, although thankfully I now have a sane
> ISP.
>
> MX checking is as broken or more broken than bayes.
>
> There is another reason bayes is not very good too - every good spammer
> reruns their message through spamassassin adding random text till they
> get a good score *then* they spew it out.

that's why you don't use a fixed table like that. if the table is customized for 
your mail then it's unlikly to agree with anyone else's, so mail that will get 
through their filter wont' get through yours (and vice versa)

David Lang
