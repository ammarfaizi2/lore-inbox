Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbUKEKFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbUKEKFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 05:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbUKEKDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 05:03:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:46252 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262639AbUKEKCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 05:02:51 -0500
Date: Fri, 5 Nov 2004 11:03:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] do_wait fix for 2.6.10-rc1
Message-ID: <20041105100354.GA4339@elte.hu>
References: <418B4E86.4010709@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418B4E86.4010709@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sripathi Kodi <sripathik@in.ibm.com> wrote:

> Here is a patch that fixes a condition that can make a thread get
> stuck forever in do_wait unless manually interrupted. 

ahh ... very nice catch!

	Ingo
