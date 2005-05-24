Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVEXRCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVEXRCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVEXRA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:00:26 -0400
Received: from loon.tech9.net ([69.20.54.92]:45187 "EHLO loon.tech9.net")
	by vger.kernel.org with ESMTP id S261830AbVEXQzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:55:49 -0400
Subject: Re: inotify 0.23 errno 28 (ENOSPC)
From: Robert Love <rlove@rlove.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: bryanwilkerson@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <1116953555.6280.31.camel@laptopd505.fenrus.org>
References: <20050524163309.74541.qmail@web53401.mail.yahoo.com>
	 <1116952520.13324.38.camel@betsy>
	 <1116953555.6280.31.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Tue, 24 May 2005 12:55:39 -0400
Message-Id: <1116953739.13324.42.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 18:52 +0200, Arjan van de Ven wrote:

> why isn't this an rlimit instead ?

Definitely could be.

Since inotify is built as a driver, the sysfs entry made sense, and it
sure is easier to implement.

But I'd have no problem with an rlimit.  We don't seem to add those
frequently, though.

	Robert Love


