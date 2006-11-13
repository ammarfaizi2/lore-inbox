Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755179AbWKMRWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbWKMRWW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbWKMRWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:22:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32460 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755179AbWKMRWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:22:20 -0500
Subject: Re: [patch 2/4] permission mapping for sys_syslog operations
From: Arjan van de Ven <arjan@infradead.org>
To: Zack Weinberg <zackw@panix.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       jmorris@namei.org, linux-kernel@vger.kernel.org
In-Reply-To: <eb97335b0611130917j18191c0ej3220b10c090d686f@mail.gmail.com>
References: <20061113064043.264211000@panix.com>
	 <20061113064058.779558000@panix.com>
	 <1163409918.15249.111.camel@laptopd505.fenrus.org>
	 <eb97335b0611130129r7cdb8c8cuc8f2360e1f17f8f3@mail.gmail.com>
	 <1163411238.15249.114.camel@laptopd505.fenrus.org>
	 <eb97335b0611130917j18191c0ej3220b10c090d686f@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 18:22:04 +0100
Message-Id: <1163438525.15249.181.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 09:17 -0800, Zack Weinberg wrote:
> On 11/13/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Mon, 2006-11-13 at 01:29 -0800, Zack Weinberg wrote:
> > > I thought the point of the "unifdef" thing was that it made a version
> > > of the header with the __KERNEL__ section ripped out, for copying into
> > > /usr/include, so you didn't have to do that ...
> >
> > yes it is, however it's mostly for existing stuff/seamless transition.
> > It's a hack :)
> > If you can avoid it lets do so; you already have the nice clean header,
> > so lets not go backwards... you HAVE the clean separation.
> 
> ok, but I gotta ask that you tell me what to name the internal header,
> I can't think of anything that isn't ugly.

klog.h vs klogd.h ? or klog_api.h for the user one ?

(and yes I suck at names even more than you do ;)

> 
> zw
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

