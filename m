Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWDOJyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWDOJyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 05:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWDOJyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 05:54:16 -0400
Received: from mail1.kontent.de ([81.88.34.36]:64656 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932477AbWDOJyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 05:54:15 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jon Masters <jcm@redhat.com>
Subject: Re: [RFC] binary firmware and modules
Date: Sat, 15 Apr 2006 11:54:22 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <1145088656.23134.54.camel@localhost.localdomain>
In-Reply-To: <1145088656.23134.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604151154.22787.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 15. April 2006 10:10 schrieb Jon Masters:
> The attached patch introduces MODULE_FIRMWARE as one way of advertising
> that a particular firmware file is to be loaded - it will then show up
> via modinfo and could be used e.g. when packaging a kernel. I've also
> given an example via the QLogic gla2xxx driver.

Strictly speaking, what is the connection with modules? Statically
compiled drivers need their firmware, too. Secondly, do all drivers
know at compile time which firmware they'll need?

	Regards
		Oliver
