Return-Path: <linux-kernel-owner+w=401wt.eu-S932318AbWLNKpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWLNKpc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWLNKpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:45:32 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53735 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932318AbWLNKpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:45:31 -0500
Date: Thu, 14 Dec 2006 10:53:46 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Doug Thompson <norsk5@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] EDAC: Fix in e752x mc driver
Message-ID: <20061214105346.10b5c2a1@localhost.localdomain>
In-Reply-To: <701304.80899.qm@web50103.mail.yahoo.com>
References: <701304.80899.qm@web50103.mail.yahoo.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 17:17:45 -0800 (PST)
Doug Thompson <norsk5@yahoo.com> wrote:

> From: Mike Chan <mikechan@google.com>
> 
> Diff against 2.6.19
> 
> This fix/change returns the offset into the page for
> the ce/ue error, instead of just 0. The e752x dram controller reads
> 34:6 of the
> linear address with the error.
> 
> Mike Chan
> 
> Signed-off-by: Mike Chan <mikechan@google.com>
> Signed-off-by: doug thompson <norsk5@xmission.com>

Acked-by: Alan Cox <alan@redhat.com>
