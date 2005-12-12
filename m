Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVLLOjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVLLOjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 09:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVLLOjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 09:39:19 -0500
Received: from cantor.suse.de ([195.135.220.2]:29670 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751212AbVLLOjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 09:39:18 -0500
From: Andreas Schwab <schwab@suse.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: ebiederm@xmission.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       pj@sgi.com, rth@twiddle.net, davej@redhat.com, zwane@arm.linux.org.uk,
       ak@suse.de, ashok.raj@intel.com
Subject: Re: [PATCH] move pm_power_off and pm_idle declaration to common code
References: <E1EloGS-0005gf-00@dorka.pomaz.szeredi.hu>
	<m1pso29z37.fsf@ebiederm.dsl.xmission.com>
	<E1Elof7-0005j7-00@dorka.pomaz.szeredi.hu>
X-Yow: ...A housewife is wearing a polypyrene jumpsuit!!
Date: Mon, 12 Dec 2005 15:39:11 +0100
In-Reply-To: <E1Elof7-0005j7-00@dorka.pomaz.szeredi.hu> (Miklos Szeredi's
	message of "Mon, 12 Dec 2005 15:28:21 +0100")
Message-ID: <jepso2752o.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

>> Does powerpc still build?  A key question is how do we handle architectures
>> that always want to want to call machine_power_off.
>
> I didn't (and can't) check, but it should.  IIRC multiple declaration
> of a variable is OK, as long as at most one has an initializer.

And as long as you don't build with -fno-common.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
