Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWJCUuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWJCUuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 16:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWJCUuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 16:50:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030387AbWJCUue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 16:50:34 -0400
Date: Tue, 3 Oct 2006 13:50:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: mchehab@infradead.org
cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/43] V4L/DVB updates for 2.6.19
In-Reply-To: <20061003182228.PS25158600000@infradead.org>
Message-ID: <Pine.LNX.4.64.0610031349500.3952@g5.osdl.org>
References: <20061003182228.PS25158600000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Oct 2006, mchehab@infradead.org wrote:
> 
> Please pull these from master branch at:
>         kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

What about this?

  drivers/media/dvb/dvb-usb/Kconfig:72:warning: 'select' used by config 
  symbol 'DVB_USB_DIB0700' refer to undefined symbol 'DVB_DIB7000M'

Hmm?

		Linus
