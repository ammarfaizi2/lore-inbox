Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVBCEJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVBCEJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 23:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVBCEJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 23:09:07 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:29644 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262958AbVBCEIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 23:08:35 -0500
Message-ID: <4201A3B4.2040605@austin.rr.com>
Date: Wed, 02 Feb 2005 22:08:20 -0600
From: "Jonathan A. George" <jageorge@austin.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Please open sysfs symbols to proprietary modules
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As an observation:

The Linux kernel appears to contain the GPL copyright notice.  This 
appears to explicitly releases the right to alter anything in a copy 
written work which shares that copyright notice.  Therefore,  all 
exported symbols would appear to carry equal weight; thus making the 
GPL_ prefix a notation of dubious value.   Furthermore, it seems as if 
that the copyright might allow changing the GPL_ prefix notation to 
anything including BSD_HOOK_FOR_PORTING_DRIVERS_TO_THE_LINUX_KERNEL_ 
instead.

It would seem just as surprising if the U.S. courts were to stop 
considering history of enforcement in copyright law as it would if they 
were to start considering in cases of patent law.

(I would love to see the opinion of an IP lawyer who has conclusively 
tested these aspects of copyright law in court.)

--------------------

A paranoid approach it to develop your driver targeted at FreeBSD, and 
then develop a glue layer abstraction for porting to other OS's.  Then 
you simply might GPL your glue layer code as a module using any symbols 
you want for your GPL copy written code per the observations earlier in 
this email.

In this way you will have created a work with no intrinsic dependencies 
on the Linux kernel which avoids presenting your work as an obvious 
target for those who prefer to spend their time looking for targets. :-)

--------------------

P.S. Sorry about breaking mailer threading. :-(
