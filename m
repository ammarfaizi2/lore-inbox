Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVFVVHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVFVVHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVFVVEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:04:31 -0400
Received: from [85.8.12.41] ([85.8.12.41]:38072 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262519AbVFVVDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:03:31 -0400
Message-ID: <42B9D21F.7040908@drzeus.cx>
Date: Wed, 22 Jun 2005 23:03:27 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: jgarzik@pobox.com
Subject: 2.6.12 breaks 8139cp
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrading from 2.6.11 to 2.6.12 caused my 8139cp network card to stop
working. No error messages are emitted and everything seems to work
(from the local computers point of view). But nothing can be recieved
from the network.

Since 8139cp.c hasn't undergone any significant changes between the
versions the bug must be in something related. Any ideas?

Rgds
Pierre
