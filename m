Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVKDRms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVKDRms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVKDRms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:42:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750760AbVKDRms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:42:48 -0500
Date: Fri, 4 Nov 2005 09:42:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Herrmann <AHERRMAN@de.ibm.com>
Cc: viro@ftp.linux.org.uk, heicars2@de.ibm.com, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-Id: <20051104094212.23f07ce7.akpm@osdl.org>
In-Reply-To: <OFDDB8F7D0.1B3A39C6-ONC12570AF.00570609-C12570AF.005739CC@de.ibm.com>
References: <OFDDB8F7D0.1B3A39C6-ONC12570AF.00570609-C12570AF.005739CC@de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Herrmann <AHERRMAN@de.ibm.com> wrote:
>
> Obviously you missed the point that (depending on the compiler version,
>  options etc.) do_move_mount() and do_add_mount() can be inlined.

I think we found a way of preventing the 3.x compiler from doing that.  Arjan,
do you recall where we ended up with that problem?
