Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263939AbUFDOki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUFDOki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 10:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUFDOki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 10:40:38 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:9648 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263939AbUFDOkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 10:40:36 -0400
Message-ID: <40C08A0D.9010003@yahoo.fr>
Date: Fri, 04 Jun 2004 16:41:17 +0200
From: Eric BEGOT <eric_begot@yahoo.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre5
References: <20040603022432.GA6039@logos.cnet>
In-Reply-To: <20040603022432.GA6039@logos.cnet>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>Hi, 
>
>Here goes -pre5.
>
>This time we have merges from Jeff's -netdrivers tree, David's -net tree, 
>including a fix for compilation error without CONFIG_SCTP set, SPARC64 update,
>i810_audio fixes, amongst others.
>
>  
>
when compiling linux-2.4.27-pre5 under a x86 architecture, I've a lot of 
warnings :

In file included from 
/usr/src/devel//usr/src/devel/include/linux/modules/i386_ksyms.ver:127:1: 
warning: "__ver_atomic_dec_and_lock" redefined
In file included from /usr/src/devel/include/linux/modversions.h:70,
                from <command line>:8:
/usr/src/devel/include/linux/modules/dec_and_lock.ver:1:1: warning: this 
is the location of the previous definition

__ver_atomic_dec_and_lock is declared two times. Maybe it lacks a #ifdef 
somewhere in the modversions.h no ?
The compilation doesn't fail bu it's not very nice :)
