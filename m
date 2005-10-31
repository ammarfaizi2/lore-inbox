Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVJaK2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVJaK2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVJaK2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:28:10 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:38556 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932446AbVJaK2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:28:09 -0500
Date: Mon, 31 Oct 2005 11:28:10 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
Message-ID: <20051031102810.GA13389@uio.no>
References: <20051030023557.GA7798@uio.no> <20051030101148.GA18854@outpost.ds9a.nl> <20051030104527.GB32446@uio.no> <20051030110021.GA19680@outpost.ds9a.nl> <20051030113651.GA1780@uio.no> <20051030114537.GA20564@outpost.ds9a.nl> <20051030115430.GA2747@uio.no> <20051031072020.GA5028@capsaicin.mamane.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051031072020.GA5028@capsaicin.mamane.lu>
X-Operating-System: Linux 2.6.14-rc5 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.8 (--)
X-Spam-Report: Status=No hits=-2.8 required=5.0 tests=ALL_TRUSTED version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 08:20:20AM +0100, Lionel Elie Mamane wrote:
>> strace doesn't show the address except when something fails, but these are
>> the distinct calls to recvmsg with given addresses (sorted):
> Try "strace -e verbose=none" to always get an address.

Well, the address was definitely valid (as the gdb session showed). Anyhow,
the machine is down to 2.6.13.4 now (otherwise same .config file, etc.), and
it seems to have fixed the problem (>10 hours with no problem so far).

/* Steinar */
-- 
Homepage: http://www.sesse.net/
