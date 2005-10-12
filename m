Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVJLM0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVJLM0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 08:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVJLM0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 08:26:52 -0400
Received: from [81.2.110.250] ([81.2.110.250]:1728 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932427AbVJLM0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 08:26:52 -0400
Subject: RE: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to
	aterminating (PF_EXITING) process.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F36B12E@mtk-sms-mail01.digi.com>
References: <335DD0B75189FB428E5C32680089FB9F36B12E@mtk-sms-mail01.digi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Oct 2005 13:55:30 +0100
Message-Id: <1129121730.4741.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you know if there was any particular reason why it was changed that
> signals can't be delivered to an exiting process in 2.6?
> Was there maybe some sort of race, and this was the best way to resolve
> it?

I have no idea. It may be a change due to the threaded signal support.
Ask whoever hacked up the signal code last I guess.

