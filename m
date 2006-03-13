Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWCMJLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWCMJLS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWCMJLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:11:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:14865 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932203AbWCMJLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:11:17 -0500
Date: Mon, 13 Mar 2006 10:11:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: James Yu <cyu021@gmail.com>
Cc: Ben Dooks <ben@fluff.org>, linux-kernel@vger.kernel.org
Subject: Re: weird behavior from kernel
Message-ID: <20060313091111.GA13786@w.ods.org>
References: <60bb95410603111923icba8adeid90c1dfa94f2e566@mail.gmail.com> <20060312084632.GB21493@w.ods.org> <60bb95410603120125n24c3a283xe1fabeb255c8c59b@mail.gmail.com> <20060312213720.GB25816@home.fluff.org> <60bb95410603122341w74ca1d97k9bda52fd71d06d18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60bb95410603122341w74ca1d97k9bda52fd71d06d18@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 03:41:44PM +0800, James Yu wrote:
> It's a custom board I got, and the official 2.6 doesn't work on it. So
> I have to use 2.4.
> 
> I tried -fno-strength-reduce option, and it doesn't seem to work though.
> Still looking for solutions~

Other possibilities involve uninitialized variables which can get different
values depending on the code generated.

Regards,
Willy

