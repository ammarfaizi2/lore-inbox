Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbRDXS5V>; Tue, 24 Apr 2001 14:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135718AbRDXS5M>; Tue, 24 Apr 2001 14:57:12 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:6909 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S132338AbRDXS5H>; Tue, 24 Apr 2001 14:57:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Device Registry (DevReg) Patch 0.2.0
Date: Tue, 24 Apr 2001 20:57:27 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01042403082000.05529@cookie> <01042413442601.00792@cookie> <03f201c0ccde$a3bde0f0$de00a8c0@homeip.net>
In-Reply-To: <03f201c0ccde$a3bde0f0$de00a8c0@homeip.net>
MIME-Version: 1.0
Message-Id: <01042420572700.00935@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 April 2001 18:43, mirabilos wrote:
> What about indenting? I think of 0 spaces before the device name,
> 1 space before properties which belong to the device. 
> Structure per entry:
>    [Space] Name colon property

But what is the advantage? Its not less work in the kernel, and in user-space 
you need to write a parser for this. You would have made a new format for 
hierarchical data that no one else uses only to avoid using XML in the 
kernel. 


> Is one level enough? I'm currently offline so didn't check the sample

No, for example for USB you have the levels 
devices/configurations/interfaces/endpoints. 

bye...
