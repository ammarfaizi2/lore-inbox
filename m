Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUAVRJG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 12:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUAVRJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 12:09:06 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48635 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266303AbUAVRJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 12:09:04 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH: Shutdown IDE before powering off.
Date: Thu, 22 Jan 2004 18:13:28 +0100
User-Agent: KMail/1.5.3
Cc: ncunningham@users.sourceforge.net, john@grabjohn.com,
       linux-kernel@vger.kernel.org
References: <1074735774.31963.82.camel@laptop-linux> <20040122004554.26536158.akpm@osdl.org> <400FF433.2010906@pobox.com>
In-Reply-To: <400FF433.2010906@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401221813.28711.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 of January 2004 17:02, Jeff Garzik wrote:
> I'm either shock or very very worried that the reboot notifier that
> flushes IDE in 2.4.x, ide_notifier, is nowhere to be seen in 2.6.x :(
> That seems like the real problem -- the code _used_ to be there.

Yep, it should be re-added.  I wonder when/why it was removed?

--bart

