Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTDWPsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbTDWPsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:48:25 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:3343
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264094AbTDWPrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:47:48 -0400
Subject: Re: kernel ring buffer accessible by users
From: Robert Love <rml@tech9.net>
To: Werner Almesberger <wa@almesberger.net>
Cc: Julien Oster <frodo@dereference.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20030423125602.B1425@almesberger.net>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
	 <1051031876.707.804.camel@localhost> <20030423125602.B1425@almesberger.net>
Content-Type: text/plain
Message-Id: <1051113589.707.948.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 23 Apr 2003 11:59:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 11:56, Werner Almesberger wrote:

> How do you know what is sensitive information ? A kernel debug
> message may just say something like "bad message 47 65 68 65 69 6d",
> and the kernel has no idea that this is actually a password

Why on earth would the user give the kernel a password?

The point is user input like telephone numbers or passwords should never
be fed into the kernel anyhow.  On the rare case it is (apparently this
ISDN instance, assuming it is actually from dmesg and not syslog), the
kernel should not echo it.

	Robert Love

