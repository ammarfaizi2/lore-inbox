Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbUCIRSq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbUCIRSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:18:45 -0500
Received: from ns.suse.de ([195.135.220.2]:41354 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261967AbUCIRSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:18:42 -0500
To: Stephen Samuel <samuel@bcgreen.com>
Cc: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>,
       linux-admin@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Redirection of STDERR
References: <20040308111349.030feea6.Christoph.Pleger@uni-dortmund.de>
	<404DEAFD.8090802@bcgreen.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: What I need is a MATURE RELATIONSHIP with a FLOPPY DISK...
Date: Tue, 09 Mar 2004 18:18:38 +0100
In-Reply-To: <404DEAFD.8090802@bcgreen.com> (Stephen Samuel's message of
 "Tue, 09 Mar 2004 08:04:13 -0800")
Message-ID: <jehdwylz0x.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Samuel <samuel@bcgreen.com> writes:

> Christoph Pleger wrote:
>> Hello,
>> In my initialization scripts for hotplug (written for bash) the
>> following command is used to redirect output which normally goes to
>> stderr to the system logger:
>> "exec 2> >(logger -t $0[$$])"
> I don't remember this syntax as legal.

That's the process substitution feature of bash, quite handy when you want
to get an fd connected to a pipe.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
