Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVAFVNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVAFVNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVAFVJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:09:03 -0500
Received: from [213.146.154.40] ([213.146.154.40]:55213 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263026AbVAFU7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:59:40 -0500
Date: Thu, 6 Jan 2005 20:59:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106205931.GA25043@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <Michael.Waychison@Sun.COM>,
	"Paul E. McKenney" <paulmck@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
	pbadari@us.ibm.com, markv@us.ibm.com,
	viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <20050106191355.GA23345@infradead.org> <41DDA10F.6010805@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DDA10F.6010805@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, autofsng patches (new set forthcoming) use set_fs_root/set_fs_pwd
> to pivot a call_usermodehelper process into the triggering process's
> namespace.

Once we get anywhere where this is needed we'll find a better interface
for that.  Like call_usermodehelper_in_namespace() or something even
better.

