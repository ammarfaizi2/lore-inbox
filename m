Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWCFQYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWCFQYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWCFQYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:24:20 -0500
Received: from xenotime.net ([66.160.160.81]:61104 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932092AbWCFQYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:24:19 -0500
Date: Mon, 6 Mar 2006 08:25:47 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Olivier Galibert <galibert@pobox.com>
Cc: jesper.juhl@gmail.com, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Is that an acceptable interface change?
Message-Id: <20060306082547.bc9671f8.rdunlap@xenotime.net>
In-Reply-To: <20060306161512.GB23513@dspnet.fr.eu.org>
References: <20060306011757.GA21649@dspnet.fr.eu.org>
	<1141631568.4084.2.camel@laptopd505.fenrus.org>
	<20060306155021.GA23513@dspnet.fr.eu.org>
	<9a8748490603060755r55b3584bpf0a16451a57925b5@mail.gmail.com>
	<20060306161512.GB23513@dspnet.fr.eu.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006 17:15:12 +0100 Olivier Galibert wrote:

> On Mon, Mar 06, 2006 at 04:55:02PM +0100, Jesper Juhl wrote:
> > Userspace apps should not include kernel headers, period.
> > So, userspace applications really shouldn't care.
> 
> Please excuse me if I'm a little dense here, but the kernel headers
> _define_ the userspace-kernel interface.  If you don't have them or a
> sanitized copy of them you just can't talk with the kernel at all.

JJ should/could have said what to use instead.*
You should use glibc sanitized kernel headers.

Raw kernel headers are not appropriate or supported for use in
userspace.

*: similar to some replies like "No" without further explanation.

---
~Randy
