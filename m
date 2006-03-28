Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWC1RlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWC1RlU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWC1RlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:41:20 -0500
Received: from smtpout.mac.com ([17.250.248.85]:37347 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751224AbWC1RlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:41:20 -0500
In-Reply-To: <20060328172847.GA2826@nevyn.them.org>
References: <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net> <44271E88.6040101@tremplin-utc.net> <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com> <Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr> <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com> <442960B6.2040502@tremplin-utc.net> <7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com> <ufazmjaec9q.fsf@epithumia.math.uh.edu> <54199D84-7DB7-434E-BA83-9B2658182124@mac.com> <20060328172847.GA2826@nevyn.them.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BDF2FE89-1A1F-4FCF-9A56-FD1952E28366@mac.com>
Cc: Jason L Tibbitts III <tibbs@math.uh.edu>,
       Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [OT] Non-GCC compilers used for linux userspace
Date: Tue, 28 Mar 2006 12:41:12 -0500
To: Daniel Jacobowitz <dan@debian.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 28, 2006, at 12:28:47, Daniel Jacobowitz wrote:
> On Tue, Mar 28, 2006 at 12:13:15PM -0500, Kyle Moffett wrote:
>> On Mar 28, 2006, at 11:59:13, Jason L Tibbitts III wrote:
>>>>>>>> "KM" == Kyle Moffett <mrmacman_g4@mac.com> writes:
>>>> So does anybody compile userspace under anything other than GCC  
>>>> or Intel compilers?  Do any such compilers even exist?
>>>
>>> PGI and PathScale are around.  Lahey, too, although they seem to  
>>> just do Fortran now.
>>>
>>> I doubt you'd want to worry about compiling the entire userland  
>>> with these compilers, however.
>>
>> Mainly I want to know if I should even bother making the kabi  
>> headers compile with anything other than GCC.  Judging from the  
>> apparently negligible number of users, it doesn't sound like  
>> something I should spend much or any time on, at least for now.
>
> I'm not sure how you got to that conclusion.  People have already  
> named several non-GCC compilers that are used; and most of the  
> users of commercial compilers won't be reading this list.
>
> If you want glibc to ever include these things, they had better be  
> portable C and work without GCC.  Otherwise it's a non-starter.   
> Only GCC may be used to build glibc, but it deliberately supports  
> any conforming C compiler to build userspace code.

Ok, my email was a bit premature (I've gotten a couple other private  
emails about other compilers too) and if people see this as an issue  
then I'll try to make all the code C89-compliant from the start.  I  
just didn't want to go writing a whole bunch of compatibility macros  
only to find out that they never got used.

Cheers,
Kyle Moffett

