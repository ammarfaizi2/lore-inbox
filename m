Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVIGADo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVIGADo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 20:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVIGADo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 20:03:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751152AbVIGADn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 20:03:43 -0400
Date: Tue, 6 Sep 2005 17:01:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: mchehab@brturbo.com.br
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: [PATCH 01/24] V4L: Common part Updates and tuner additions
Message-Id: <20050906170128.243a3a39.akpm@osdl.org>
In-Reply-To: <431cb7f6.3a1Y2AL2UcB0Asbo%mchehab@brturbo.com.br>
References: <431cb7f6.3a1Y2AL2UcB0Asbo%mchehab@brturbo.com.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Two of these patches:

v4l-adds-the-adapter-number-and-i2c-address-to.patch
v4l-allows-clearer-message-prefixes-containing-the-i2c-for-tveeprom_hauppauge_analog.patch

throw great reject storms, due to changes in Linus's current tree.  Greg's
i2c stuff.

I'm not confident that the v4l changes will work without those two patches
and I'm not confident that they'll work against all the i2c changes, so
could you please redo all these patches against current -linus or most
recent -mm, retest and resend?

Thanks.

