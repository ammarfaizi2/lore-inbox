Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313472AbSD3NEF>; Tue, 30 Apr 2002 09:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSD3NEE>; Tue, 30 Apr 2002 09:04:04 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:41229 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313419AbSD3NED>; Tue, 30 Apr 2002 09:04:03 -0400
Message-Id: <200204301300.g3UD0mX02997@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: How to enable printk
Date: Tue, 30 Apr 2002 16:03:08 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204301210.g3UC9qX02863@Port.imtp.ilyichevsk.odessa.ua> <29915.1020080236@redhat.com> <21805.1020171317@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 April 2002 10:55, David Woodhouse wrote:
> vda@port.imtp.ilyichevsk.odessa.ua said:
> >  It is not silly as long as kernel continues to log tons of normal
> > stuff as warnings.
>
> Er, IMO it _is_ silly as long as the kernel continues to log real warnings
> as warnings too.
>
> > Here it is: There are way too many printks without a log level! --
>
> Oh, well the answer is obvious - just disable _all_ the warning messages.
>
> Why not turn off KERN_CRIT too, while we're at it? I'm sure we can find at
> least one superfluous KERN_CRIT message.

Hey, hey... do you expect users to patch all those printk() calls 
in their kernel themself? Realistically they can:

* enable console logging for warnings and be flooded
* disable console logging for warnings and stay blind
* send patches to lkml and be ignored
* configure syslogd to print warnings on a dedicated tty

Anyway, that's what I did.
--
vda
