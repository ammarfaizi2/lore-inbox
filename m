Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272485AbTHFWC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272578AbTHFWC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:02:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:2972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272485AbTHFWC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:02:56 -0400
Date: Wed, 6 Aug 2003 15:04:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [2.6] system is very slow during disk access
Message-Id: <20030806150434.53c4fa8c.akpm@osdl.org>
In-Reply-To: <200308062129.47113.fsdeveloper@yahoo.de>
References: <200308062052.10752.fsdeveloper@yahoo.de>
	<200308062129.47113.fsdeveloper@yahoo.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <fsdeveloper@yahoo.de> wrote:
>
>  I just tried to run the test-scenario on my other Linux-installation
>  on this machine with kernel 2.4.10 and there the output of the program
>  was quite smooth, even it dd was running und the system was still usable.

Please boot the 2.6 machine with "profile=1" on the kernel boot command line.

start the `dd', do a `readprofile -r', wait ten seconds, do

	readprofile -m /wherever/System.map

then post the results.

Thanks.
