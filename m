Return-Path: <linux-kernel-owner+w=401wt.eu-S1750836AbWLMUqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWLMUqN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWLMUqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:46:12 -0500
Received: from webserve.ca ([69.90.47.180]:38625 "EHLO computersmith.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750836AbWLMUqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:46:11 -0500
Message-ID: <45806641.5010105@wintersgift.com>
Date: Wed, 13 Dec 2006 12:44:49 -0800
From: Teunis Peters <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question: removal of syscall macros?
References: <45804B99.2060008@wintersgift.com> <a36005b50612131201j766d7585yad6d77629582d468@mail.gmail.com>
In-Reply-To: <a36005b50612131201j766d7585yad6d77629582d468@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ulrich Drepper wrote:
> On 12/13/06, Teunis Peters <teunis@wintersgift.com> wrote:
>> Now that syscall macros have been pulled from the -mm tree, what method
>> is recommended to use syscalls?
> 
> glibc forever had a syscall() function for just that purpose.  It was
> never a good idea to use the macros since they didn't work in PIC.

sorry - I should be a little more context specific.

for KERNEL modules that used the _syscallX macros - what mechanism should be used?
I'm aware that the drivers I'm having a problem with (ATI, vmware) are closed source - but my own work machine's dependant on it and I'm not going to waste another 3 months to get
a response from either company.

and since the macros were pulled...  and I'm kind of stuck with bleeding edge until some of the other hardware I'm working with is supported...  *frustrated sigh*
At the moment my workaround is just to copy the macros from released kernel in.   I don't like that solution - but it DOES work.

Unless someone can suggest a low-price but recent - and still sold - laptop model that works well with linux.  (rhetorical - if anyone DOES answer, keep it off the list - thanks *g*)
- - Teunis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgGZBbFT/SAfwLKMRAvAWAJ91BZCCIFrcGTkPaahf+Vd+tPvtewCfee/g
6BAirwLkefSqJbqGruk3L3o=
=Mr7+
-----END PGP SIGNATURE-----
