Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWHHR5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWHHR5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWHHR5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:57:12 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:58572 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030215AbWHHR5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:57:12 -0400
Message-ID: <44D8D073.5080505@oracle.com>
Date: Tue, 08 Aug 2006 10:57:07 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       James.Bottomley@HansenPartnership.com
Subject: Re: PATCH: Voyager, tty locking
References: <1155060469.5729.109.camel@localhost.localdomain>
In-Reply-To: <1155060469.5729.109.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The signal handling also appears to be incorrect as it does an
> unprotected sigfillset that also appears unneccessary. As I don't have a
> bowtie and am therefore not a qualified voyager maintainer I leave that
> to James.

Bowtie or not, you touched it last!

This seems like a decent candidate for being moved over to the kthread API..

- z
