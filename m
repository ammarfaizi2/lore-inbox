Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTBXWAv>; Mon, 24 Feb 2003 17:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbTBXWAu>; Mon, 24 Feb 2003 17:00:50 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:51717 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S267599AbTBXWAu>;
	Mon, 24 Feb 2003 17:00:50 -0500
Subject: Re: hard lockup on 2.4.20 w/ nfs over frees/wan
From: Shaya Potter <spotter@cs.columbia.edu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030220164420.GA9800@gtf.org>
References: <1045634189.4761.44.camel@zaphod>
	 <1045686971.8084.2.camel@zaphod> <1045757772.31762.13.camel@zaphod>
	 <20030220164420.GA9800@gtf.org>
Content-Type: text/plain
Organization: 
Message-Id: <1046124651.10146.1.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 17:10:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seems to be stable w/ the 2.4.19 driver.  All the tests that I ran be
(basically kernel building over nfs over ipsec) that hung it hard
consistently b4 aren't hanging it now.

shaya

On Thu, 2003-02-20 at 11:44, Jeff Garzik wrote:
> On Thu, Feb 20, 2003 at 11:16:13AM -0500, Shaya Potter wrote:
> > moved from the netfinity's onboard pcnet32 adapter to an IBM branded
> > Intel epro/100 w/ the intel driver in 2.4.20 and it appears very
> > stable.  Is it possible the pcnet/32 adapter is broken or the driver is
> > buggy?
> 
> I have gotten reports the 2.4.20 pcnet32 is buggy.
> 
> Can you test 2.4.20 with 2.4.19 version of pcnet32.c?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

