Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTEEIK5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTEEIK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:10:57 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:19465 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262093AbTEEIKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:10:55 -0400
Date: Mon, 5 May 2003 09:23:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505092324.A13336@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Terje Eggestad <terje.eggestad@scali.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052122784.2821.4.camel@pc-16.office.scali.no>; from terje.eggestad@scali.com on Mon, May 05, 2003 at 10:19:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 10:19:45AM +0200, Terje Eggestad wrote:
> Now that it seem that all are in agreement that the sys_call_table
> symbol shall not be exported to modules, are there any work in progress
> to allow modules to get an event/notification whenever a specific
> syscall is being called?

No.

> We have a specific need to trace mmap() and sbrk() calls. 

Well, you get mmap events for your driver and I can't imagine a sane
reason for intwercepting sbrk().  Do you have a pointer to the driver
source doing such strange things?

