Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268703AbUI2QTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbUI2QTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbUI2QTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:19:46 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:44292 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268700AbUI2QTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:19:41 -0400
Date: Wed, 29 Sep 2004 17:19:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, brian.b@hp.com
Subject: Re: patch so cciss stats are collected in /proc/stat
Message-ID: <20040929171926.A14606@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mike.miller@hp.com,
	mikem@beardog.cca.cpqcorp.net, marcelo.tosatti@cyclades.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	brian.b@hp.com
References: <20040929161345.GB22308@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040929161345.GB22308@beardog.cca.cpqcorp.net>; from mike.miller@hp.com on Wed, Sep 29, 2004 at 11:13:45AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 11:13:45AM -0500, mike.miller@hp.com wrote:
> Currently cciss statistics are not collected in /proc/stat. This patch
> bumps DK_MAX_MAJOR to 111 to fix that. This has been a common complaint
> by customers wishing to gather info about cciss devices.
> Please consider this for inclusion. Applies to 2.4.28-pre3.

This patch has been reject about half a million times, why are people
submitting it again and again?

You get more detailed statistics in /proc/partitions.

