Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264619AbUDVShb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbUDVShb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUDVShb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:37:31 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:49414 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264619AbUDVSha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:37:30 -0400
Date: Thu, 22 Apr 2004 19:37:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jord Tanner <jord@indygecko.com>
Cc: Paul Wagland <paul@wagland.net>, linux-kernel@vger.kernel.org,
       Atulm@lsil.com
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
Message-ID: <20040422193720.A25117@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jord Tanner <jord@indygecko.com>, Paul Wagland <paul@wagland.net>,
	linux-kernel@vger.kernel.org, Atulm@lsil.com
References: <0E3FA95632D6D047BA649F95DAB60E57033BC53C@exa-atlanta.se.lsil.com> <1082143294.11606.81.camel@gecko> <A1E28594-9478-11D8-B5AA-000A95CD704C@wagland.net> <1082658137.22804.1563.camel@gecko>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1082658137.22804.1563.camel@gecko>; from jord@indygecko.com on Thu, Apr 22, 2004 at 11:22:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 11:22:17AM -0700, Jord Tanner wrote:
> filled with FF), so I think there may be multiple causes. We were
> running XFS on LVM2 on linux RAID0 on megaraid RAID1.

That looks like eating lots of stack...  So you might aswell have had stack
overruns.

