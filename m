Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVFOJn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVFOJn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 05:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVFOJn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 05:43:58 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:50384 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261375AbVFOJny convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 05:43:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Aj8q2f5XeHi0kya56VK6HhePvX38QmDfnZ7gBQwisjIv5bzHGFc41PV5yGK7u3QAPLg6R0DpDv/8zc3HqBDFtoEG6rcmssbm0v9c7452K5HWAAJcvswSgr2N14mOVRfCK1QsKms1KWzi+tZl1dkJVRjEM9KAza9ym5P5DWCwemw=
Message-ID: <2cd57c9005061502432a44bbef@mail.gmail.com>
Date: Wed, 15 Jun 2005 17:43:51 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: Why is one sync() not enough?
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200506151228.27474.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050614094141.GE1467@schottelius.org>
	 <42AFE432.8000204@aitel.hist.no>
	 <200506151228.27474.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> On Wednesday 15 June 2005 11:17, Helge Hafting wrote:
> > Nico Schottelius wrote:
> >
> > >Hello again!
> > >
> > >When my system shuts down and init calls sync() and after that
> > >umount and then reboot, the filesystem is left in an unclean state.
> > >
> > >If I do sync() two times (one before umount, one after umount) it
> > >seems to work.
> 
> sync before umount is superfluous.
 
BTW, how about sysrq-s and sysrq-u? The same?
-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
