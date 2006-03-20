Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWCTT0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWCTT0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWCTT0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:26:11 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:41959 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751280AbWCTT0K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:26:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pc4DTxST6DEXyekblqIZttWcq9oPGAh+2TB0tpapS++gC7Ru1gNDDkTa9vCRrmg+S8bdIKqLZqb7Yp1uy/oLPiTJqOCXRw01YY/J8zwUFlnnX9TauPyAJYFsVbKacKxvZ6DWON9R1qrFe79Pn00PfA5myaPZdoyScsKkU8dbZcU=
Message-ID: <7c3341450603201126j7c579d9fu@mail.gmail.com>
Date: Mon, 20 Mar 2006 19:26:07 +0000
From: "Nick Warne" <nick@linicks.net>
Reply-To: "Nick Warne" <nick@linicks.net>
To: "Alejandro Bonilla" <abonilla@linuxwireless.org>
Subject: Re: kernel hda errors on dmesg - new VFS messages
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060320162753.M3577@linuxwireless.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060318081134.M30026@linuxwireless.org>
	 <17915ac50603180054l4c3c6646ifcdee47e8f76887c@mail.gmail.com>
	 <20060319235255.M28695@linuxwireless.org>
	 <20060320033955.GC18898@eugeneteo.net>
	 <20060320162753.M3577@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/06, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:

> -I inserted a CD and:-
> [4294853.924000] UDF-fs: No VRS found
> [4294854.199000] UDF-fs: No VRS found
> [4294854.517000] ISO 9660 Extensions: Microsoft Joliet Level 3
> [4294854.579000] ISO 9660 Extensions: RRIP_1991A

> any idea?

Do you use KDE?  I had a problem once with /dev/hdd being hammered
very similar (but this _was_ a CD-ROM).

If you do use KDE look in Control Center->KDE Components->Service
Manager.  There is a service called 'KDED Media manager' that was
causing my problems.  I turned it off.

Just an idea.

Nick
