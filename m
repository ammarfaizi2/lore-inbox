Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVF1Tcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVF1Tcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVF1Tce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:32:34 -0400
Received: from graphe.net ([209.204.138.32]:59833 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261193AbVF1Tbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:31:34 -0400
Date: Tue, 28 Jun 2005 12:31:33 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
In-Reply-To: <87hdfi704d.fsf@jbms.ath.cx>
Message-ID: <Pine.LNX.4.62.0506281230550.1630@graphe.net>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net> <87oe9q70no.fsf@jbms.ath.cx>
 <Pine.LNX.4.62.0506281218030.1454@graphe.net> <87hdfi704d.fsf@jbms.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Jeremy Maitin-Shepard wrote:

> It would probably be better implemented with a more generic mechanism,
> but I don't believe anyone is working on that now, so it looks like AFS
> will continue to use a special syscall.

We could put an #ifdef CONFIG_AFS into the syscall table definition?
That makes it explicit.


