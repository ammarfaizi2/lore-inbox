Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262172AbSJJTOh>; Thu, 10 Oct 2002 15:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbSJJTN3>; Thu, 10 Oct 2002 15:13:29 -0400
Received: from email.gcom.com ([206.221.230.194]:702 "EHLO gcom.com")
	by vger.kernel.org with ESMTP id <S262165AbSJJTM2>;
	Thu, 10 Oct 2002 15:12:28 -0400
Message-Id: <5.1.0.14.2.20021010140426.0271c6a0@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 10 Oct 2002 14:07:28 -0500
To: Christoph Hellwig <hch@infradead.org>
From: David Grothe <dave@gcom.com>
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       LiS <linux-streams@gsyc.escet.urjc.es>, davem@redhat.com,
       bidulock@openss7.org
In-Reply-To: <20021010182740.A23908@infradead.org>
References: <5.1.0.14.2.20021010115616.04a0de70@localhost>
 <4386E3211F1@vcnet.vc.cvut.cz>
 <5.1.0.14.2.20021010115616.04a0de70@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:27 PM 10/10/2002 Thursday, Christoph Hellwig wrote:
>a) please read Documentation/CodingStyle

Is there a specific problem here?  We tried to imitate the kernel coding 
style with this patch.

>b) please add a prototype in a header

Can you suggest which header file would be appropriate?  I would be glad to 
add the prototype there.

>c) please make it EXPORT_SYMBOL_GPL
LiS is LGPL.  Would it work if the exported symbol was GPL only?

As this is something of a replacement for the old exported sys_call_table, 
which was exported generally, we thought that a general export was appropriate.

Thanks,
Dave

