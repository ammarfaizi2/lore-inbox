Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWDTRHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWDTRHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWDTRHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:07:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:12974 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751168AbWDTRGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:06:44 -0400
Date: Thu, 20 Apr 2006 12:05:59 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Sam Vilain <sam@vilain.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
Message-ID: <20060420170559.GA25899@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.E40C119B902@sergelap.hallyn.com> <4446547B.4080206@sw.ru> <m1wtdlmvmr.fsf@ebiederm.dsl.xmission.com> <20060419175123.GD1238@sergelap.austin.ibm.com> <m1ejztjua2.fsf@ebiederm.dsl.xmission.com> <4446AF56.9060706@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4446AF56.9060706@vilain.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Vilain (sam@vilain.net):
> Eric W. Biederman wrote:
> 
> >>Is it time to ask for the utsname namespace patch to be tried out
> >>in -mm?
> >>    
> >>
> >
> >Can we please suggest a syscall interface?
> >  
> >
> 
> What was wrong with the method of the one I posted / extracted from the
> Linux-VServer project? I mean, apart from the baggage which I intend to
> remove for the next posting.
> 
> The concept was - have a single syscall with versioned subcommands. We
> can throw all of the namespace syscalls in there.
> 
> Sam.

Well IIUC on the whole having one syscall multiplexing onto various
commands is frowned upon.  But please resubmit when you're ready, and
we'll see what ppl think of it.

Can you have a version on top of my utsname patches, hooking into the
utsname unsharing fn?

thanks,
-serge
