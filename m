Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTELUz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbTELUz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:55:58 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:29666 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S262703AbTELUz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:55:57 -0400
Subject: Re: USB mouse freezes under X, 2.5.69-mm3
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030512210222.GA29652@kroah.com>
References: <1052772819.4835.6.camel@serpentine.internal.keyresearch.com>
	 <20030512210222.GA29652@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052773722.5781.1.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 May 2003 14:08:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 14:02, Greg KH wrote:

> Does this also happem on a non-mm kernel?

I'll see.  It's not easy to reproduce, though it has happened to me
twice today.

> The hid driver never increments its user count, even when being used.
> Same goes for the USB host controller drivers, so this is not a problem.

OK, thanks.

	<b

