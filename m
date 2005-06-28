Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVF1Tmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVF1Tmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVF1Tml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:42:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53952 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261219AbVF1TmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:42:23 -0400
Date: Tue, 28 Jun 2005 20:42:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Jeremy Maitin-Shepard <jbms@cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
Message-ID: <20050628194215.GB32240@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <christoph@lameter.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0506281141050.959@graphe.net> <87oe9q70no.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281218030.1454@graphe.net> <87hdfi704d.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281230550.1630@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506281230550.1630@graphe.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 12:31:33PM -0700, Christoph Lameter wrote:
> On Tue, 28 Jun 2005, Jeremy Maitin-Shepard wrote:
> 
> > It would probably be better implemented with a more generic mechanism,
> > but I don't believe anyone is working on that now, so it looks like AFS
> > will continue to use a special syscall.
> 
> We could put an #ifdef CONFIG_AFS into the syscall table definition?
> That makes it explicit.

No.  AFS is utterly wrong, and the sooner we make it fail to work the better.

