Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUIBNdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUIBNdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268315AbUIBNdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:33:12 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:3094 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268312AbUIBNdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:33:08 -0400
Message-ID: <93e09f0104090206334a708289@mail.gmail.com>
Date: Thu, 2 Sep 2004 19:03:08 +0530
From: Rohit Neupane <rohitneupane@gmail.com>
Reply-To: Rohit Neupane <rohitneupane@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Weird Problem with TCP
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1094122617.4966.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <93e09f0104090202216403c08d@mail.gmail.com> <1094122617.4966.0.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Sep 2004 11:56:59 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > * Everything works fine for about 5-10 mins then all of a sudden TCP services
> > are not accessable.
> > * For some reason TCP times out. However at the same time ping,traceroute and
> > dns trace works without any problem.
> > * The connected TCP sokets keeps working without any problem. I verified this
> > by using Msn chat. I observerd that I chat session ( which I had started
> > when everything was normal) continued without any problem however I was not
> > able to initiate a new chat session.
> 
> Are you using session tracking. The symptoms you describe are
> classically those of session tracking nat/firewalling/whatever running
> out of table entries and being unable to allow new connections.
> 
No, it is not running any session tracking (ip_conntrack) neither it
does nat. It is just a firewall with around 1600 rules in FORWARD
mangle table and around 1500 rules in FORWARD filter table. Out of
1500 rules , 1377 rules are MAC filter rules.
And it had 3 alias address for the interface conneted to the wirelss.

regards,
Rohit


>
