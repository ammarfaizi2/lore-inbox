Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754351AbWKMJrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbWKMJrc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754366AbWKMJrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:47:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39827 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754351AbWKMJrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:47:31 -0500
Subject: Re: [patch 2/4] permission mapping for sys_syslog operations
From: Arjan van de Ven <arjan@infradead.org>
To: Zack Weinberg <zackw@panix.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       jmorris@namei.org, linux-kernel@vger.kernel.org
In-Reply-To: <eb97335b0611130129r7cdb8c8cuc8f2360e1f17f8f3@mail.gmail.com>
References: <20061113064043.264211000@panix.com>
	 <20061113064058.779558000@panix.com>
	 <1163409918.15249.111.camel@laptopd505.fenrus.org>
	 <eb97335b0611130129r7cdb8c8cuc8f2360e1f17f8f3@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 10:47:17 +0100
Message-Id: <1163411238.15249.114.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 01:29 -0800, Zack Weinberg wrote:
> On 11/13/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > you had such a nice userspace/kernel shared header.. and now you mix it
> > with kernel privates again... can you consider making this a second
> > header?
> 
> I thought the point of the "unifdef" thing was that it made a version
> of the header with the __KERNEL__ section ripped out, for copying into
> /usr/include, so you didn't have to do that ...

yes it is, however it's mostly for existing stuff/seamless transition.
It's a hack :)
If you can avoid it lets do so; you already have the nice clean header,
so lets not go backwards... you HAVE the clean separation. 

> 
> zw
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

