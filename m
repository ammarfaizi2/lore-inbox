Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263673AbUEGQUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbUEGQUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 12:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUEGQUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 12:20:31 -0400
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:41430 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263673AbUEGQU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 12:20:26 -0400
Message-ID: <409BB71F.9090601@stesmi.com>
Date: Fri, 07 May 2004 18:19:43 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
CC: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>	<20040504200147.GA26579@kroah.com> <s5ghduvdg1u.fsf@patl=users.sf.net>	<200405060033.49380.oliver@neukum.org> <s5gekpxslti.fsf@patl=users.sf.net>
In-Reply-To: <s5gekpxslti.fsf@patl=users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick.

>>The set of devices connected to the machine is not static. Waiting
>>until all hardware is ready is very hard to even define.
> 
> It is very easy to define for 99.999% of all keyboards, which start
> off connected and stay connected.
> 
> This should be simple.  I want to load a driver at boot time and wait
> until it either binds to something or fails to do so.  If the user is

But that means that the driver must include some sort of arbitrary
timelimit. Why push that from userspace to the driver?

// Stefan
