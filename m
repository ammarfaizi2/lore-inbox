Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWEQGgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWEQGgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 02:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWEQGgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 02:36:43 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:31407 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932441AbWEQGgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 02:36:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=U4Qb0DtXT0iJSGRQBjXb8N2m2GBl4E8vIfT/3nfhUVf/AIYaNAyfgGHk9m7Fg2Q+7poThMlvNI3jpJNDdvmTeu4Z4+sDSN/Lz9h4xbmp34XG56Ok9DktlEhwhqSB7ghjH1Gn5n7ccaG71B39sxk0T7jPQV0XEJzX7dOWBSpGcys=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64ync-mailbox><next-undeleted><enter-command>set editor=vim
Date: Wed, 17 May 2006 08:36:40 +0200
User-Agent: KMail/1.8.3
Cc: Alberto Bertogli <albertito@gmail.com>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <20060514182541.GA4980@gmail.com> <20060516191244.GB6337@ccure.user-mode-linux.org> <20060517023942.GI9066@gmail.com>
In-Reply-To: <20060517023942.GI9066@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605170836.41009.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 May 2006 04:39, Alberto Bertogli wrote:
> On Tue, May 16, 2006 at 03:12:44PM -0400, Jeff Dike wrote:
> > On Mon, May 15, 2006 at 12:29:58PM -0300, Alberto Bertogli wrote:
> > > Sure, here it is:
> > > (gdb) disas stub_segv_handler
> >
> > Sorry, I misread the error message and asked for the wrong thing.
> > Your UML is seeing a process segfault during a system call, before the
> > SIGTRAP expected at the end of the system call.  I don't know what's
> > happening there.
> >
> > Can you apply the following patch, which will just give you a register
> > dump of the process, and send me the output?
>
> Here it is. While the patch worked, it was for 2.6.16, and I'm using
> 2.6.17-rc4, I hope that's not a problem.

Guess not - I'll test this patch soon because I have the same problem, however 
are you running a 2.6.16 host?

If so, can you verify whether on a 2.6.15 host kernel the same binary runs 
fine (as is the case for me)?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
