Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265377AbUF2CeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUF2CeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 22:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUF2CeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 22:34:19 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:38167 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S265377AbUF2CeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 22:34:15 -0400
Message-Id: <5.1.0.14.2.20040629122704.04958ec8@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 29 Jun 2004 12:34:01 +1000
To: "David S. Miller" <davem@redhat.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: TCP-RST Vulnerability - Doubt
Cc: saiprathap <saiprathap@cc.usu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20040625150532.1a6d6e60.davem@redhat.com>
References: <40DC9B00@webster.usu.edu>
 <40DC9B00@webster.usu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:05 AM 27/06/2004, David S. Miller wrote:
> > Could you kindly share your views regarding what Linux has done to its 
> stack
> > to overcome this vulnerability as it will be of great help to my research.
>
>We have done nothing, and there are no plans to implement any workaround
>for this problem.

the vulnerabilities are real for any application/protocol which makes use 
of long-duration TCP sessions.

the most common place that people have found the vulnerability to be of use 
is in killing BGP sessions.
protocols which make use of long-held TCP sessions such as NFSv3, irc, 
nntp, telnet, ssh, X11 et al are just as vulnerable.


cheers,

lincoln.

