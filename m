Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUGZGLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUGZGLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 02:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUGZGLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 02:11:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:48774 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264371AbUGZGLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 02:11:21 -0400
Date: Sun, 25 Jul 2004 23:09:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: cw@f00f.org, rml@ximian.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-Id: <20040725230951.0e150dbe.akpm@osdl.org>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A6EBFB0@orsmsx407>
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB0@orsmsx407>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com> wrote:
>
> If you guys are up to it, I volunteer to write/port such a tool to scan 
>  out the send_kevent{_atomic,}()s and make a catalog out of it.

I must say that my gut feeling here is that bolting an arbitrary new
namespace into the kernel in this manner is not the way to proceed.

I hope we'll hear more from Greg on this next week - see if we can come up
with some way to use the kobject/sysfs namespace for this.

Although heaven knows how "tmpfs just ran out of space" would map onto
kobject/sysfs.
