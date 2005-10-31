Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVJaHU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVJaHU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVJaHU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:20:28 -0500
Received: from 213-84-114-29.adsl.xs4all.nl ([213.84.114.29]:21936 "EHLO
	capsaicin.mamane.lu") by vger.kernel.org with ESMTP id S932310AbVJaHU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:20:27 -0500
Date: Mon, 31 Oct 2005 08:20:20 +0100
From: Lionel Elie Mamane <lionel@mamane.lu>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
Message-ID: <20051031072020.GA5028@capsaicin.mamane.lu>
Mail-Followup-To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
	bert hubert <bert.hubert@netherlabs.nl>,
	linux-kernel@vger.kernel.org
References: <20051030023557.GA7798@uio.no> <20051030101148.GA18854@outpost.ds9a.nl> <20051030104527.GB32446@uio.no> <20051030110021.GA19680@outpost.ds9a.nl> <20051030113651.GA1780@uio.no> <20051030114537.GA20564@outpost.ds9a.nl> <20051030115430.GA2747@uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030115430.GA2747@uio.no>
X-Operating-System: GNU/Linux
X-Request-PGP: http://www.mamane.lu/openpgp/rsa_v4_4096.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:54:30PM +0100, Steinar H. Gunderson wrote:
> On Sun, Oct 30, 2005 at 12:45:38PM +0100, bert hubert wrote:

>> Check if the address passed, 0x561329b0, is very different from addresses
>> passed during regular operations.

> strace doesn't show the address except when something fails, but these are
> the distinct calls to recvmsg with given addresses (sorted):

Try "strace -e verbose=none" to always get an address.

-- 
Lionel
