Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292617AbSCRTqZ>; Mon, 18 Mar 2002 14:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292555AbSCRTqL>; Mon, 18 Mar 2002 14:46:11 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:5638 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S292594AbSCRTpn>;
	Mon, 18 Mar 2002 14:45:43 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jason Li <jli@extremenetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMBOL doesn't work 
In-Reply-To: Your message of "Mon, 18 Mar 2002 11:11:46 -0800."
             <3C963BF2.C9D78479@extremenetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Mar 2002 06:45:32 +1100
Message-ID: <9584.1016480732@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002 11:11:46 -0800, 
Jason Li <jli@extremenetworks.com> wrote:
>Now another problem with versioning. It seems even after I have the
>following in my module c file the symbol generated is not versioned:
>
>#define MODULE
>#include <linux/modversions.h>
>#include <linux/kernel.h>

Never include modverversions.h yourself, the kernel build process
automatically includes it when required.  See also
http://www.tux.org/lkml/#s8-8.

