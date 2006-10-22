Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWJVXDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWJVXDP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 19:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWJVXDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 19:03:15 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:60854 "EHLO mailbox.ines.ro")
	by vger.kernel.org with ESMTP id S1750766AbWJVXDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 19:03:14 -0400
Subject: Re: Strange errors from e1000 driver (2.6.18)
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <453BD41B.4010007@google.com>
References: <453BBC9E.4040300@google.com> <453BC0E7.1060308@mbligh.org>
	 <4807377b0610221321i62455faende025f88142dd087@mail.gmail.com>
	 <453BD41B.4010007@google.com>
Content-Type: text/plain
Organization: iNES Group
Date: Mon, 23 Oct 2006 02:02:43 +0300
Message-Id: <1161558163.2720.4.camel@DustPuppy.LNX.RO>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Milter 1.6.2 on MailBox.iNES.RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-22 at 13:27 -0700, Martin J. Bligh wrote:
> Jesse Brandeburg wrote:
> > On 10/22/06, Martin J. Bligh <mbligh@mbligh.org> wrote:
> >> Martin J. Bligh wrote:
> >> > I'm getting a lot of these type of errors if I run 2.6.18. If
> >> > I run the standard Ubuntu Dapper kernel, I don't get them.
> >> > What do they indicate?
> > 
> > Hi Martin, they indicate that you're getting transmit hangs.  Means
> > your hardware is having issues with some of the buffers it is being
> > handed.  Because the TDH and TDT noted below are not equal, it means
> > the hardware is hung processing buffers that the driver gave to it.
> > 
> > We need the standard bug report particulars,
> 
> Sure.
> 
> Handle 0x0001, DMI type 1, 25 bytes.
> System Information
> 	Manufacturer: VIA Technologies, Inc.
> 	Product Name: KT600-8237
> 	Version:  
> 	Serial Number:  
> 	UUID: Not Present
> 	Wake-up Type: Power Switch


If this matters: I've got the same errors with the fc5 kernel sometime
around january, also on an VIA-based motherboard. I only got around to
fix it by changing the motherboard... (worked fine with an intel-based
mb).


-- 
Cioby


