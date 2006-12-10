Return-Path: <linux-kernel-owner+w=401wt.eu-S1760593AbWLJJiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760593AbWLJJiB (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 04:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760600AbWLJJiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 04:38:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57935 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760593AbWLJJiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 04:38:00 -0500
Subject: Re: PAE/NX without performance drain?
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <457B1F02.7030409@comcast.net>
References: <457B1F02.7030409@comcast.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 10 Dec 2006 10:37:57 +0100
Message-Id: <1165743478.27217.187.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 15:39 -0500, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Apparently (as I've been told today) using a hardware NX bit in a 32-bit
> x86 kernel requires PAE mode.  PAE mode is enabled with HIGHMEM64, which
> is (apparently) extremely slow.


it's not extremely slow. 

there is a minor performance delta, sure, but to be honest that's a
benchmark thing more than a real life thing.

What did your measurements show that the slowdown was? And how did you
measure this?



