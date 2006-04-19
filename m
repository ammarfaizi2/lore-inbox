Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWDSS3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWDSS3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWDSS3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:29:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44426 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750947AbWDSS3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:29:15 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap>
	<20060407183600.E40C119B902@sergelap.hallyn.com>
	<4446547B.4080206@sw.ru> <m1wtdlmvmr.fsf@ebiederm.dsl.xmission.com>
	<20060419175123.GD1238@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Apr 2006 12:27:01 -0600
In-Reply-To: <20060419175123.GD1238@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Wed, 19 Apr 2006 12:51:23 -0500")
Message-ID: <m1ejztjua2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> Kirill Korotaev <dev@sw.ru> writes:
>> 
>> > Serge,
>> >
>> > can we do nothing with sysctls at this moment, instead of commiting hacks?
>> 
>> Except that we modify a static table changing the uts behaviour in
>> proc_doutsstring isn't all that bad.
>> 
>> I'm just about to start on something more comprehensive, in
>> the sysctl case.
>
> So assuming that I take out the switch(), leaving that for a better
> solution by Eric (or Dave, or whoever),
>
> Is it time to ask for the utsname namespace patch to be tried out
> in -mm?

Can we please suggest a syscall interface?

Eric




