Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422708AbWJLPug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbWJLPug (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422715AbWJLPug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:50:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42685 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422708AbWJLPuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:50:35 -0400
Subject: Re: Userspace process may be able to DoS kernel
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?G=FCnther?= Starnberger <gst@sysfrog.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 12 Oct 2006 11:51:29 -0400
Message-Id: <1160668290.24931.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 12:54 -0400, Günther Starnberger wrote:
> The lockup usually occurs when Skype 1.3.x for Linux (I'm using
> 1.3.0.53) sits around idle for some time and then (presumably) uses
> the sound device (i.e. for me it happens when I call a contact -
> others reported this problem occurs for incoming messages [there may
> be an audio notification of the messages enabled]). The lockup can
> take from several seconds (where it is not detected by the kernel) up
> to some minutes. The whole system seems to be blocked - i.e. there is
> not even disk IO.

Do you get the same behavior using the old OSS drivers that you get with
ALSA's OSS emulation?

Lee

