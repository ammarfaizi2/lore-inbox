Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbULSWTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbULSWTm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbULSWTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 17:19:41 -0500
Received: from peabody.ximian.com ([130.57.169.10]:41182 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261344AbULSWTk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 17:19:40 -0500
Subject: Re: What does atomic_read actually do?
From: Robert Love <rml@novell.com>
To: Joseph Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <opsi707edhs29e3l@grunion>
References: <opsi7o5nqfs29e3l@grunion>
	 <1103394867.4127.18.camel@laptopd505.fenrus.org> <opsi7xcuizs29e3l@grunion>
	 <1103399680.4127.20.camel@laptopd505.fenrus.org> <opsi707edhs29e3l@grunion>
Content-Type: text/plain
Date: Sun, 19 Dec 2004 17:21:06 -0500
Message-Id: <1103494866.6052.354.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-18 at 15:43 -0500, Joseph Seigh wrote:

> > it does so on *x86
> 
> Is this documented for gcc anywhere?  Just because it does so doesn't
> mean it's guaranteed.

Listen to what Arjan is saying: It is not a compiler feature.  x86
already guarantees that an aligned word-size read is atomic in the
nothing-can-interleave sense.

	Robert Love


