Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbTFCQXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbTFCQXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:23:50 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:56328 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265084AbTFCQXq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:23:46 -0400
From: Steve Brueggeman <xioborg@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA CHIPSET KT 400 / 8235 troubleshooting
Date: Tue, 03 Jun 2003 11:37:13 -0500
Message-ID: <tdjpdv0ed43luavghf65hfa8jbp7o2u51m@4ax.com>
References: <0060478E58FDD611A4A200508BCF7BD97BF752@pleyel.chant.com> <bbhli0$v5j$1@ask.hswn.dk> <1054629097.2723.7.camel@sonja>
In-Reply-To: <1054629097.2723.7.camel@sonja>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Soyo KT400 Dragon Ultra which would hang at boot unless I
specified "noapic".

linux-2.4.21-rc6-ac1 boots fine with APIC enabled, without the
"noapic" kernel parameter.

So, to install Mandrake 9.1, specify the "noapic" parameter, and once
installed, give linux-2.4.21-rc6-ac1 a try.


Alan, thanks for the fix.  I was beginning to wonder if my KT400
chipset would be supported by a stable kernel.

Steve Brueggeman

On 03 Jun 2003 10:31:37 +0200, you wrote:

>Am Die, 2003-06-03 um 10.17 schrieb Henrik Storner:
>
>> My KT400 motherboard (Soltek) requires me to boot with the "noapic"
>> parameter, or it will hang in a similar manner. Did you try that,
>> or did you just enable/disable the APIC in the BIOS ?
>
>My ECS L7VTA will boot with APIC enabled but has interrupt problems 
>with at least the NIC and thus will stop booting (over network that is).
>Alan told me yesterday in private that he thinks he knows the problem
>and has a solution in his -ac series.
>
>Haven't had a chance to try that though...

