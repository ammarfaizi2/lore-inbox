Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVJDTSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVJDTSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVJDTSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:18:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30859 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964935AbVJDTSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:18:21 -0400
Date: Tue, 4 Oct 2005 20:18:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Leimbach <leimy2k@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /etc/mtab and per-process namespaces
Message-ID: <20051004191818.GA31328@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Leimbach <leimy2k@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com> <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect not one cares about /etc/mtab.  It's a pretty horrible
interface.  Use /proc/self/mounts if your care about the mount table
for your current namespace, it's guranteed uptodate.

