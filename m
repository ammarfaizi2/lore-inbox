Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263168AbUDMIgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUDMIgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:36:11 -0400
Received: from zork.zork.net ([64.81.246.102]:28842 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263168AbUDMIgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:36:07 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm5 devpts filesystem doesn't work
References: <20040412221717.782a4b97.akpm@osdl.org>
	<407B9FB1.8070107@aitel.hist.no>
	<20040413011133.2d15a4d6.akpm@osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Helge Hafting
 <helgehaf@aitel.hist.no>,  linux-kernel@vger.kernel.org
Date: Tue, 13 Apr 2004 09:36:01 +0100
In-Reply-To: <20040413011133.2d15a4d6.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 13 Apr 2004 01:11:33 -0700")
Message-ID: <6uad1gs2a6.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Helge Hafting <helgehaf@aitel.hist.no> wrote:
>>
>> I tried stepping up from 2.6.5-rc3-mm4 to 2.6.5-mm4.
>> This Quokka seems too zonked to work though.
>> 
>> It came up, but I couldn't run "xterm".  Trying from
>> the xemacs shell I saw an error message about not enough ptys.
>> I use the devpts fs mounted on /dev/pts
>> 
>> It mounts just fine, but doesn't work apparently.  There are no
>> such problems with 2.6.5-rc3-mm4
>
> Is this 2.6.5-mm4 or 2.6.5-mm5?
>
> If the latter, try reverting pty-allocation-first-fit.patch

Also seeing this with 2.6.5-mm5, reverting pty-allocation-first-fit.patch
fixes it.

