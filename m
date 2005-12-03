Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbVLCVO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbVLCVO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVLCVO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:14:57 -0500
Received: from covilha.procergs.com.br ([200.198.128.244]:22693 "EHLO
	covilha.procergs.com.br") by vger.kernel.org with ESMTP
	id S1750993AbVLCVO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:14:56 -0500
From: Otavio Salvador <otavio@debian.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] OSS: replace all uses of pci_module_init with pci_register_driver
Organization: O.S. Systems Ltda.
References: <11336254302237-git-send-email-otavio@debian.org>
	<20051203205627.GB4573@kroah.com>
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
Date: Sat, 03 Dec 2005 19:15:46 -0200
In-Reply-To: <20051203205627.GB4573@kroah.com> (Greg KH's message of "Sat, 3
	Dec 2005 12:56:27 -0800")
Message-ID: <873bl93mrh.fsf@nurf.casa>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Sat, Dec 03, 2005 at 01:57:10PM -0200, Otavio Salvador wrote:
>> This patch replace all calls to pci_module_init, that's deprecated and
>> will be removed in future, with pci_register_driver that should be
>> the used function now.
>
> Sorry, but Richard Knutsson <ricknu-0@student.ltu.se> already did all of
> this last week.  His patches are in the latest -mm release, and are in
> my queue too.

No problem. He did it on all source or just oss subsystem?

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
