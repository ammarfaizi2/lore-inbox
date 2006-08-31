Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWHaVeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWHaVeB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWHaVeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:34:01 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:23490 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932127AbWHaVeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:34:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=a9OXjfQQyR71VtSuACuRBMuKOEkoN6PAmxEjrZZOqRCWd4Ry0PK3Yc/J8m/11ROGL4hw+59Nxro1doDoDas55oGujLalC0LO0RJKuZEv1pUpdMnKB4xe/FvBEvnnkz065WWRh0OC5cE3atY0M15a1NvGm04s2xtMpQwHiChO0Us=
Message-ID: <44F755C2.8090007@gmail.com>
Date: Fri, 01 Sep 2006 01:33:54 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: Lee Revell <rlrevell@joe-job.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
References: <20060830062338.GA10285@kroah.com>	 <1157013027.7566.515.camel@capoeira>  <1157056749.4386.137.camel@mindpipe>	 <1157057934.24286.3.camel@bip.parateam.prv>	 <1157058734.4386.142.camel@mindpipe> <1157059114.24286.7.camel@bip.parateam.prv>
In-Reply-To: <1157059114.24286.7.camel@bip.parateam.prv>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> Le jeudi 31 août 2006 à 17:12 -0400, Lee Revell a écrit :
>> On Thu, 2006-08-31 at 22:58 +0200, Xavier Bestel wrote:
>>> Precisely. How do you know the bugreport you received isn't caused by
>>> some weird binary userspace driver hosing the PCI bus ? 
>> Can't X, or any application that access hardware directly by
>> mmaping /dev/mem, do this now?
> 
> Yes they can, but X's behavior is pretty well known by now :) and it's
> open source.
> 

what about binary drivers in kernel like nVidia or ATI ?

Well above all, user-space drivers can be of help in a lot of other
ways. An example is rapid prototyping. Some times it makes sense as well
to do in user-space, where you can really control things. Drivers using
math is an example


Manu
