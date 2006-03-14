Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWCNVvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWCNVvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWCNVvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:51:24 -0500
Received: from duke.cs.duke.edu ([152.3.140.1]:65527 "EHLO duke.cs.duke.edu")
	by vger.kernel.org with ESMTP id S1751944AbWCNVvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:51:24 -0500
Date: Tue, 14 Mar 2006 16:51:13 -0500 (EST)
From: Tong Li <tongli@cs.duke.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bursty I/O in ext3
In-Reply-To: <20060314152952.GA5644@thunk.org>
Message-ID: <Pine.GSO.4.62.0603141650160.4481@eenie.cs.duke.edu>
References: <Pine.GSO.4.62.0603140150420.1352@eenie.cs.duke.edu>
 <20060314152952.GA5644@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you are using an e2fsprogs older than version 1.38, you should try
> expanding the journal size from the default of 32M to 128M; with the
> filesystem unmounted do:
>
> 	tune2fs -O ^has_journal /dev/hdXX
> 	tune2fs -O has_journal -J journal_size=128 /dev/hdXX
>

I did this and yes, it fixed the problem.

Thank you so much,

   tong
