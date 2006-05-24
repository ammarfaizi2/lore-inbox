Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbWEXIM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbWEXIM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 04:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWEXIM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 04:12:56 -0400
Received: from wmp-pc40.wavecom.fr ([81.80.89.162]:38150 "EHLO
	domino.wavecom.fr") by vger.kernel.org with ESMTP id S932651AbWEXIMz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 04:12:55 -0400
In-Reply-To: <1148408496.24623.18.camel@localhost.localdomain>
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OFD8B7556E.13DD6F3A-ONC1257178.002C2D9A-C1257178.002D1FC5@wavecom.fr>
From: Yann.LEPROVOST@wavecom.fr
Date: Wed, 24 May 2006 10:06:50 +0200
X-MIMETrack: Serialize by Router on domino/wavecom(Release 6.5.4|March 27, 2005) at 05/24/2006
 10:06:53 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The debug serial unit is part of the mainline kernel, this is the common
link to work with the CSB637 Cogent board.
I don't know about others AT91RM9200 based board.

AT91RM9200 also have others USART, but there are no available output
connectors on the CSB637 board.

Yann



                                                                           
             Steven Rostedt                                                
             <rostedt@goodmis.                                             
             org>                                                       To 
                                       Yann.LEPROVOST@wavecom.fr           
             23/05/2006 20:21                                           cc 
                                       Daniel Walker <dwalker@mvista.com>, 
                                       linux-kernel@vger.kernel.org,       
                                       linux-kernel-owner@vger.kernel.org, 
                                       Ingo Molnar <mingo@elte.hu>, Thomas 
                                       Gleixner <tglx@linutronix.de>       
                                                                   Subject 
                                       Re: Ingo's  realtime_preempt patch  
                                       causes kernel oops                  
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




On Tue, 2006-05-23 at 19:10 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> Currently there are only system timer and debug serial unit registered on
> irq line 1.
> Debug serial unit is used as the console !
>

That scares me.  Is the debug serial unit added by you, or is it part of
the mainline kernel?

-- Steve




