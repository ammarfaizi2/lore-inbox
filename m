Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWC1SqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWC1SqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWC1SqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:46:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48796 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750919AbWC1SqW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:46:22 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [OT] Non-GCC compilers used for linux userspace
References: <200603141619.36609.mmazur@kernel.pl>
	<20060326065205.d691539c.mrmacman_g4@mac.com>
	<4426A5BF.2080804@tremplin-utc.net>
	<200603261609.10992.rob@landley.net>
	<44271E88.6040101@tremplin-utc.net>
	<5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
	<Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr>
	<36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com>
	<442960B6.2040502@tremplin-utc.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Mar 2006 11:44:03 -0700
In-Reply-To: <442960B6.2040502@tremplin-utc.net> (Eric Piel's message of
 "Tue, 28 Mar 2006 18:13:42 +0200")
Message-ID: <m1zmjammto.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Piel <Eric.Piel@tremplin-utc.net> writes:

> 03/28/2006 05:57 PM, Kyle Moffett wrote/a écrit:
>> But my question still stands.  Does anybody actually use any non-GCC compiler
>> for userspace in Linux?
> At least in the domain of HPC, I've seen people which were compiling mostly
> *everything* with the intel compiler (x86 and ia64) for performance
> reason. So... yes userspace is sometimes compiled with non-GCC compiler :-)

The pathscale, and pgi compilers also get a reasonable amount of use.

pathscale has a gcc derived front-end so it isn't to much to worry about.

The pgi compiler as I recall is a fairly pedantic c90 compiler, that
doesn't try and support gcc extensions.

Eric
