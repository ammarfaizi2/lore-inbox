Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267819AbUHPRXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267819AbUHPRXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUHPRXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:23:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4340 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267813AbUHPRXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:23:40 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Mon, 16 Aug 2004 19:23:19 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815151346.GA13761@devserv.devel.redhat.com>
In-Reply-To: <20040815151346.GA13761@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408161923.19024.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 August 2004 17:13, Alan Cox wrote:
> There really isnt any sane way to break this patch down because all the
> changes are interlinked so closely.

at least /proc/ide/hd?/settings:ide-scsi removal and doc fixes are very easy 
to separate, I also think that locking fixes should be separated from 
hotplugging ones
