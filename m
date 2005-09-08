Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVIHNRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVIHNRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVIHNRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:17:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8322 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751347AbVIHNRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:17:38 -0400
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Reuse of BIOs
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 08 Sep 2005 14:17:31 +0100
Message-ID: <11859.1126185451@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jens,

Is it possible to reuse a BIO once the callback on it has been invoked to
indicate final completion? Or does it have to be released and another one
allocated?

David
