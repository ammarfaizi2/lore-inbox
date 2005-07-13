Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVGMFjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVGMFjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 01:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVGMFju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 01:39:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12766 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262588AbVGMFjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 01:39:49 -0400
Date: Tue, 12 Jul 2005 22:39:47 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Joe Sevy <jmsevy@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb mass storage bug
Message-Id: <20050712223947.796a4939.zaitcev@redhat.com>
In-Reply-To: <mailman.1121114341.22024.linux-kernel2news@redhat.com>
References: <mailman.1121114341.22024.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005 13:30:47 -0700 (PDT), Joe Sevy <jmsevy@yahoo.com> wrote:

> Sorry, no logs or dmesg to report; just performance.
> Using kernel 2.6.12: USB flash drive (san-disk cruzer
> micro) Copy FROM drive is normal and quick; copy TO
> drive is amazingly slow. (30 minutes for 50K file).
> Used same configuration as for 2.6.11.11. Cured by
> going back to old kernel.

Symptoms seem similar to this:
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=159269

Try 2.6.13-rc2, it would be a valuable data point.

-- Pete
