Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVHOOOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVHOOOz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 10:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVHOOOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 10:14:55 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:47300 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964774AbVHOOOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 10:14:55 -0400
Subject: Re: Vendor specific SCSI opcodes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1124112848.1945.14.camel@localhost.localdomain>
References: <1124112848.1945.14.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Aug 2005 15:42:12 +0100
Message-Id: <1124116932.5287.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-15 at 15:34 +0200, Mathieu Fluhr wrote:
> So is there a way to bypass this command verification and to let the
> program work without launching it as root user ?

If there was what would be the point in having a root user. The vendor
specific commands include functionality like "erase firmware" that
simply isn't appropriate to give to unprivileged applications.


