Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTL2P02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 10:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbTL2P02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 10:26:28 -0500
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:20613 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S263600AbTL2P00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 10:26:26 -0500
Subject: Re: 2.4.23 can run with HZ==0!
From: Rob Love <rml@ximian.com>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031229125240.GA4055@janus>
References: <20031228230522.GA1876@janus>
	 <1072691126.5223.5.camel@laptop.fenrus.com>  <20031229125240.GA4055@janus>
Content-Type: text/plain
Message-Id: <1072711585.4294.8.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 29 Dec 2003 10:26:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-29 at 07:52, Frank van Maarseveen wrote:

> Can you give me an example?

Sure, as this has already been done:

	http://www.kernel.org/pub/linux/kernel/people/rml/variable-HZ/v2.4/

As you see, that has a ton of fixups, primarily to ensure that
user-space is always exported jiffies in terms of USER_HZ==100.

> The uptime will be rather limited with 32 bits jiffies ;-) but I can live with that.

There is a patch at that same place that adds 64-bit jiffies.

	Rob Love


