Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUI1OJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUI1OJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 10:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUI1OHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 10:07:33 -0400
Received: from lists.us.dell.com ([143.166.224.162]:13455 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S267828AbUI1OG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 10:06:29 -0400
Date: Tue, 28 Sep 2004 09:06:27 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Dave Jones <davej@redhat.com>, Brian McGrew <Brian@doubledimension.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Probing for System Model Information
Message-ID: <20040928140627.GA24899@lists.us.dell.com>
References: <E6456D527ABC5B4DBD1119A9FB461E35019377@constellation.doubledimension.com> <20040928134705.GA11916@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928134705.GA11916@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 02:47:05PM +0100, Dave Jones wrote:
> On Tue, Sep 28, 2004 at 06:32:31AM -0700, Brian McGrew wrote:
>  > Good morning All!  We exclusively ship Dell boxes with our
>  > hardware.  However, we use several different models, 1400's,
>  > 1600's, 2350's, 4600's and so on.  I need to write a small
>  > program to probe the system for the model information since I
>  > don't seem to find it in the logs anywhere.  I know the model
>  > info is in there somewhere and it's accessible because if I look
>  > on the default factory installed version of Windows, it's listed.
>  > Does anyone know how to do this or can you point me to one that's
>  > already done or some samples?
>  
> You can find this info in the DMI tables assuming Dell filled
> them in with sensible data (which they usually do).

Yes, we do. :-)  I've abbreviated the output to serve as an example.

# dmidecode
Handle 0x0000
        BIOS Information Block
                Vendor: Dell Computer Corporation
                Version: A08
Handle 0x0100
        System Information Block
                Vendor: Dell Computer Corporation
                Product: PowerEdge 2400
Handle 0x0300
        Chassis Information Block
                Serial Number: MY_SERIAL_NUMBER
                Asset Tag: 0000001


Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
