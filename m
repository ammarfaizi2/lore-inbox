Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVD0SIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVD0SIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVD0SIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:08:50 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:1660 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261857AbVD0SHe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:07:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P0xvafRSq5z2qedsWR4St+l9EuNAswb7VrQsuK/HRo14I2ZIQtLxaNXbOUkFPW4QWv+RVmt3Mi5RmIZ6v7I9ji3VEbD98QS4oGn6M+per05Df3MCyqnk69nRf59V8kFdira9amI0e4WQ9U2tdJcZcXUny1P8cYxqTwiaieO43yA=
Message-ID: <2cd57c90050427110717b6e841@mail.gmail.com>
Date: Thu, 28 Apr 2005 02:07:28 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: any way to find out kernel memory usage?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <426FBFED.9090409@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <426FBFED.9090409@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Chris Friesen <cfriesen@nortel.com> wrote:
> 
> We recently had an issue with a kernel module leaking memory on unload,
> and a userspace app that unloaded it way too many times.
> 
> This ended up using up a bunch of memory, which triggered the oom-killer
> to run, which went wild killing everything in sight since userspace
> wasn't actually the culprt.
> 
> One idea we had to prevent this in the future is to configure the OOM
> killer to reset the system if the kernel uses more than a certain amount
> of memory.  (Reset is better than hang for our purposes.) Is there any

Curiously, how to reset? Reboot? (Teach oom killer to kill) or restart
the related
kernel thread?


> way to find out how much memory the kernel is using?  I don't see
> anything in /proc, but maybe something internal that isn't currently
> exported?
> 
> Chris



-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
