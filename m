Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282976AbRLMBDR>; Wed, 12 Dec 2001 20:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282968AbRLMBC5>; Wed, 12 Dec 2001 20:02:57 -0500
Received: from jhuml4.jhu.edu ([128.220.2.67]:44217 "EHLO jhuml4.jhu.edu")
	by vger.kernel.org with ESMTP id <S282967AbRLMBCw>;
	Wed, 12 Dec 2001 20:02:52 -0500
Date: Wed, 12 Dec 2001 20:03:48 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: USB not processing APM suspend event properly?
To: linux-kernel@vger.kernel.org
Message-id: <1008205428.3108.0.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sending 'n' PM_SUSPEND events because you have 'n' listeners
> on /dev/apm_bios seems to be a waste of time when it could be
> handled more cleanly.

But do you agree that the present code does NOT do this?

The present code does not send 'n' events---only one.

