Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUG0HFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUG0HFb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUG0HFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:05:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:3210 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266287AbUG0HFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:05:25 -0400
Date: Tue, 27 Jul 2004 00:03:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Janice M Girouard <janiceg@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, wenxiong@us.ibm.com,
       linux-serial@vger.kernel.org
Subject: Re: new device driver to enable the IBM Multiport Serial Adapter in
 Linux
Message-Id: <20040727000359.6e0af2e0.akpm@osdl.org>
In-Reply-To: <41055722.2070104@us.ibm.com>
References: <41055722.2070104@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janice M Girouard <janiceg@us.ibm.com> wrote:
>
> The patch below enables the IBM Multiport Serial Adapter for the Linux 
>  OS.

Looks sane.  Did you really intend that it be buildable for all
architectures?  (There's nothing wrong with this - it's good.  But it's a
bit unusual for this sort of driver).

"IBM multiport serial adapter" seems to be a rather generic description of
this device.  Is this the only multiport serial adapter which IBM has ever,
or will ever make?  If not, then perhaps we could make the description a
little more specific?

