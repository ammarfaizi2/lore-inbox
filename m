Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWEPVCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWEPVCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWEPVCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:02:32 -0400
Received: from main.gmane.org ([80.91.229.2]:13262 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750825AbWEPVCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:02:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Wiretapping Linux?
Date: Tue, 16 May 2006 22:01:36 +0100
Message-ID: <yw1xfyj91y6n.fsf@agrajag.inprovide.com>
References: <4469D296.8060908@perkel.com> <20060516200313.GO11191@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: agrajag.inprovide.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:/42a2pA+XvzQXQZaX9CQwmZ2tEs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> writes:

> On Tue, May 16, 2006 at 06:24:38AM -0700, Marc Perkel wrote:
>> As most of you know the United States is tapping you telephone calls and 
>> tracking every call you make. The next logical step is to start tapping 
>> your computer implanting spyware into operating systems. Since Windows 
>> and OS-X are proprietary this can be done more easilly with the 
>> cooperation of Microsoft and Apple.
>> 
>> So what about Linux? With thousands of people working on the Kernel if 
>> someone from the NSA wanted to slip a back door into the Kernel, could 
>> the do that? I know it's open source and it could be found if anyone 
>> looks but is anyone looking? Is this something that would get noticed if 
>> someone tried to do it? I'd like to think it would, but I'm going to ask 
>> anyway just to make sure.
>
> There is no warranty that this cannot happen. Indeed, it has already
> happened and will probably do again. A backdoor was found in some code
> introduced in the bitkeeper repository, but it was noticed almost
> immediately.

The code was not added to the bitkeeper repository, but to a CVS
mirror of it.  It was spotted quickly thanks to rigorous checksumming
done by the CVS exporter in BK.

One of the current trends in version control software is toward
cryptographically signed changesets, meaning that sneaking something
in without access to a trusted private key is about as close to
impossible as you can get.

There is still the question of who you can *really* trust of course.
After all, how do we know that Dave Miller (who was "credited" for the
mentioned backdoor attempt) isn't really a bad guy?

-- 
Måns Rullgård
mru@inprovide.com

