Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbTEHN5W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTEHN5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:57:22 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:33457 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261497AbTEHN5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:57:20 -0400
Date: Thu, 8 May 2003 10:08:37 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
Message-ID: <200305081009_MC3-1-37FA-2408@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>> > I'd make a stab at it if I knew that it stood a chance of getting
>> > accepted. 
>> 
>> I dont think it has.
>
> I think it could, actually - who maintains fortunes these days?  It's
> a bit too long, though...

  Wow, Advanced Sarcasm.  Must be part of the Graduate program...

  Meanwhile on Win2k I can intercept any IO request by
wrting a filter driver, and that driver can get control on the way
back to userspace by registering a completion routine.  Such filters
can be arbitrarily chained together and can be placed either above or
below an FSD, making such things as virus detection, HSM and disk
mirroring much easier to write...

  How would I do this on Linux?  How would virus detection and HSM
coexist?  (HSM would have to be 'above' the virus detector, since it
makes no sense to try and scan a file that's been migrated until it
gets recalled back to disk.)
