Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbVAFUjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbVAFUjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVAFUfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:35:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51389 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263014AbVAFUdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:33:01 -0500
Date: Thu, 6 Jan 2005 20:32:59 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106201531.GJ1292@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 12:15:31PM -0800, Paul E. McKenney wrote:
> Yep, you win the prize, it is MVFS.
> 
> This is the usual port of an existing body of code to the Linux kernel.
> It is not asking for a new export, only restoration of a previously existing
> export.

Sorry, but "our code is badly misdesigned" does not make a valid excuse
when you have been told, repeatedly, by many people, for at least a year
that you needed to sanitize your design.

Request denied.  And no, it never had been intended to be exported
or, indeed, used by filesystems.
