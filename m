Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131637AbRAXU6R>; Wed, 24 Jan 2001 15:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131576AbRAXU6H>; Wed, 24 Jan 2001 15:58:07 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:28427 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131368AbRAXU6C>;
	Wed, 24 Jan 2001 15:58:02 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: David Luyer <david_luyer@pacific.net.au>, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: "Pass module parameters" to built-in drivers 
In-Reply-To: Your message of "Wed, 24 Jan 2001 08:32:35 CDT."
             <3A6ED972.6636E169@yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Jan 2001 07:57:51 +1100
Message-ID: <6625.980369871@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001 08:32:35 -0500, 
Paul Gortmaker <p_gortmaker@yahoo.com> wrote:
>I'm curious as to what boot argument equivalent you envision for e.g.
>
>options ne io=0x280,0x300 irq=10,12 bad=0,1

ne.io=0x280,0x300 ne.irq=10,12 ne.bad=0,1.  I might even be generous
and handle ne{io=0x280,0x300 irq=10,12 bad=0,1}

If a parameter name is unique amongst all compiled in objects then it
does not need the object/module name, although it is recommended.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
