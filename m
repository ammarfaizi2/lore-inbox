Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278587AbRKFTFS>; Tue, 6 Nov 2001 14:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280288AbRKFTFI>; Tue, 6 Nov 2001 14:05:08 -0500
Received: from web12203.mail.yahoo.com ([216.136.173.87]:42319 "HELO
	web12203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280210AbRKFTEm>; Tue, 6 Nov 2001 14:04:42 -0500
Message-ID: <20011106190441.58124.qmail@web12203.mail.yahoo.com>
Date: Tue, 6 Nov 2001 11:04:41 -0800 (PST)
From: Amit Kulkarni <amitncsu@yahoo.com>
Subject: Re: Insmod gives unsresolved symbol
To: Tyler BIRD <BIRDTY@uvsc.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <sbe7b36f.021@MAIL-SMTP.uvsc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

these functions are defined in /net/mpls.h as extern
variables. 
I don't think there is a mpls_init.h
I have included mpls.h and hence it compiles w/o error
but only at the time of linking  it gives this error



--- Tyler BIRD <BIRDTY@uvsc.edu> wrote:
> Well you still much include the header file for the
> link
> whatever it might be.  #include
> <include/mpls_init.h>
> for example.  Only some functions such as printk
> don't need such headers.
> 
> Tyler
> 
> 
> >>> Amit Kulkarni <amitncsu@yahoo.com> 11/06/01
> 01:17AM >>>
> Hi 
> 
> I am trying to write a device driver which calls
> certain functions/variables from the kernel 
> (e.g. ipv4_explicit_null from
> /usr/src/linux/net/mpls/mpls_init.c )
> 
> But when I try to insert the module using insmod it
> gives me an error saying unresolved symbol
> ipv4_explicit_null
> 
> thinking the kernel did not export the said symbol 
> I
> added EXPORT_SYMBOL(ipv4_explicit_null) in the file
> mpls_init.c 
> Now I can see the symbol in System.map
> but my problem still persists. 
> 
> Am I exporting symbols properly or is there anything
> else that needs to be done .
> 
> please advise 
> thanks in anticipation,
> amit
> 
> __________________________________________________
> Do You Yahoo!?
> Find a job, post your resume.
> http://careers.yahoo.com
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


__________________________________________________
Do You Yahoo!?
Find a job, post your resume.
http://careers.yahoo.com
