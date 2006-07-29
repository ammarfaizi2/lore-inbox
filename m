Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161465AbWG2EdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161465AbWG2EdF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 00:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWG2EdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 00:33:04 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:33196 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1161462AbWG2EdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 00:33:02 -0400
Subject: Re: [RFC 1/4] kevent: core files.
From: Nicholas Miell <nmiell@comcast.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Zach Brown <zach.brown@oracle.com>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <44CAD81A.9060401@redhat.com>
References: <20060709132446.GB29435@2ka.mipt.ru>
	 <20060724.231708.01289489.davem@davemloft.net>
	 <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru>
	 <44C930D5.9020704@oracle.com> <20060728052312.GB11210@2ka.mipt.ru>
	 <44CA586C.4010205@oracle.com> <20060728184445.GA10797@2ka.mipt.ru>
	 <44CA613F.9080806@oracle.com>  <44CAD81A.9060401@redhat.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 21:32:42 -0700
Message-Id: <1154147562.2451.30.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 20:38 -0700, Ulrich Drepper wrote:
> Zach Brown wrote:
> > Ulrich, would you be satisfied if we didn't
> > have the userspace mapped ring on the first pass and only had a
> > collection syscall?
> 
> I'm not the one to make a call but why rush things?  Let's do it right
> from the start.  Later changes can only lead to problems with users of
> the earlier interface.
> 

Speaking of API design choices, I saw your OLS paper and was wondering
if you were familiar with the Solaris port APIs* and, if so, you could
please comment on how your proposed event channels are different/better.


* http://docs.sun.com/app/docs/doc/816-5168/6mbb3hrir?a=view

-- 
Nicholas Miell <nmiell@comcast.net>

