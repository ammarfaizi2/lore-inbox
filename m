Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTFFQWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTFFQWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:22:25 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:44699 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S261928AbTFFQWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:22:24 -0400
Subject: Re: 2.5.70 thru bk10 amd64 compile failure
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Warren Togami <warren@togami.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1054878617.3699.134.camel@laptop>
References: <1054878617.3699.134.camel@laptop>
Content-Type: text/plain
Organization: 
Message-Id: <1054917352.28218.3.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jun 2003 09:35:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 22:50, Warren Togami wrote:

> kernel-2.5.70, 2.5.70-bk9 and 2.5.70-bk10 all fail compilation here on
> my amd64 with gcc-3.2.2-10 on stock RedHat GinGin64.  Please pardon me
> if this is a duplicate report, I am now subscribing in order to keep a
> closer eye on this list.

You're compiling with CONFIG_VT turned off.  Turn it on for now, as I
don't have a patch for that problem yet.

	<b

