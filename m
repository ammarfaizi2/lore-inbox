Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbTDYMfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTDYMfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:35:39 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:5589 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263021AbTDYMfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:35:38 -0400
Subject: Re: [RFC/PATCH] IDE Power Management try 1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Alexander Atanasov <alex@ssi.bg>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0304251407440.12558-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0304251407440.12558-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051274854.567.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Apr 2003 14:47:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why can't we simply change ide_do_drive_command() to take extra
> flag specifing wait/do not wait and use it for ide_preempt?

That would do it as well.

Ben.

