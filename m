Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVKJXRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVKJXRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVKJXRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:17:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49056 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932249AbVKJXQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:16:59 -0500
Date: Thu, 10 Nov 2005 15:17:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: mchehab@brturbo.com.br
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       hverkuil@xs4all.nl
Subject: Re: [Patch 08/20] V4L (944) Subject added driver for saa7127 video
 decoder
Message-Id: <20051110151710.11304c7e.akpm@osdl.org>
In-Reply-To: <1131656168.6478.47.camel@localhost>
References: <1131656168.6478.47.camel@localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@brturbo.com.br wrote:
>
> +	struct saa7127_state *state = (struct saa7127_state *)i2c_get_clientdata(client);

i2c_get_clientdata() already returns void*.   No typecast is needed here.
