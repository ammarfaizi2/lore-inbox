Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbUDHJYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 05:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbUDHJYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 05:24:19 -0400
Received: from ns.suse.de ([195.135.220.2]:28576 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264225AbUDHJYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 05:24:17 -0400
To: Martin Rode <martin.rode@zeroscale.com>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cp fails in this symlink case, kernel 2.4.25, reiserfs + ext2
References: <1081359310.1212.537.camel@marge.pf-berlin.de>
	<1081365374.11164.24.camel@shaggy.austin.ibm.com>
	<1081410996.3770.1405.camel@marge.pf-berlin.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I just had my entire INTESTINAL TRACT coated with TEFLON!
Date: Thu, 08 Apr 2004 11:24:14 +0200
In-Reply-To: <1081410996.3770.1405.camel@marge.pf-berlin.de> (Martin Rode's
 message of "Thu, 08 Apr 2004 09:56:37 +0200")
Message-ID: <je1xmy3jr5.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Rode <martin.rode@zeroscale.com> writes:

> On Wed, 2004-04-07 at 21:16, Dave Kleikamp wrote:
>> On Wed, 2004-04-07 at 12:35, Martin Rode wrote:
>> > 5) cp fails
>> > apu:/home/martin/tmp/bug# (cd alpha/beta; cp ../latest/myfile .)
>> > cp: cannot stat `../latest/myfile': No such file or directory
>> 
>> When you cd to alpha/beta, your current directory is really
>> .../tmp/bug/beta.  Your shell may remember that you got there through
>> the symlink in alpha, but cp will follow .., which is really bug.
>
> Bug in "cp", "bash" or in the kernel fs-layer? 

Neither.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
