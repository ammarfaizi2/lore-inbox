Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWFMUpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWFMUpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWFMUpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:45:45 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:39792 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932234AbWFMUpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:45:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Yp4dp1UvFilZCmcDjk/rt1p3EO3YiNQlBAM+aw9DZeAbIgUiedgZiF2W6qTl8czXWDcvZnWyiISt1WkiCQ+85jsLS1O0yDnM19hzxl4ihP5qtelPZe5IzH8/flM42+oQPq2zW4haLSjBDWF+TgNdZgiAmd2mfKJ/O+WFHBw+wqk=
Message-ID: <986ed62e0606131345w7bdad0aap53e2edc5fea0f68f@mail.gmail.com>
Date: Tue, 13 Jun 2006 13:45:43 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "John Heffner" <jheffner@psc.edu>
Subject: Re: 2.6.17: networking bug??
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Mark Lord" <lkml@rtr.ca>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       davem@davemloft.net
In-Reply-To: <448F03B3.5040501@psc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <448EC6F3.3060002@rtr.ca> <448ECB09.3010308@rtr.ca>
	 <448ED2FC.2040704@rtr.ca> <448ED9B3.8050506@rtr.ca>
	 <448EEE9D.10105@rtr.ca> <448EF45B.2080601@rtr.ca>
	 <448EF85E.50405@psc.edu>
	 <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>
	 <448F03B3.5040501@psc.edu>
X-Google-Sender-Auth: c503dc38fe47c7cd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/06, John Heffner <jheffner@psc.edu> wrote:
> Though I haven't gotten my hands on it, I believe Windows will soon have
> this capability, too.  I'm sure Windows is big enough that whenever they
> turn this on, it will flush out all these boxes pretty quickly.  We
> could wait for them to do it first, that that's not my favored approach.

Yes, that appears to be the case with Windows Vista:
http://blogs.msdn.com/wndp/archive/2006/05/05/Winhec_blog_tcpip_2.aspx

*However*, they're also adding "black hole detection", for working
around broken boxes that drop ICMP. And that kinda makes me wonder how
long they're going to stick to their guns for enabling window scaling.
(For instance, if too many sites break, maybe they'll disable it again
with Vista Service Pack 1 or something.)
-- 
-Barry K. Nathan <barryn@pobox.com>
