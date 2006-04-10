Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWDJXmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWDJXmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWDJXmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:42:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932191AbWDJXl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:41:59 -0400
Date: Mon, 10 Apr 2006 15:38:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       steve.cameron@hp.com
Subject: Re: [PATCH 1/1] cciss: bug fix for crash when running hpacucli
Message-Id: <20060410153800.3c018fc1.akpm@osdl.org>
In-Reply-To: <20060410202541.GA28328@beardog.cca.cpqcorp.net>
References: <20060410202541.GA28328@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:
>
> This patch fixes a crash when running hpacucli with multiple logical volumes
>  on a cciss controller. We were not properly initializing the disk->queue
>  and causing a fault.

Please confirm that this is safe&appropriate for backporting into 2.6.16.x?
