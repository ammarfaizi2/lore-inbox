Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbTF1OCt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 10:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbTF1OCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 10:02:49 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:58373 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265223AbTF1OCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 10:02:49 -0400
Subject: Re: 2.5.73 - SCSI cache data unavailable messages
From: James Bottomley <James.Bottomley@steeleye.com>
To: margitsw@t-online.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Jun 2003 09:17:00 -0500
Message-Id: <1056809821.1978.2.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is happening because 10 byte mode sense was turned on a bit before
the rest of SCSI was ready for it.

The fixes for this problem are in the linux-scsi repository and should
make their way into the kernel in due course.

James



