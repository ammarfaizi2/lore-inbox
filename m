Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270426AbUJUAdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270426AbUJUAdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270505AbUJUAaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:30:15 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:65466 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270439AbUJUA3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:29:42 -0400
Date: Wed, 20 Oct 2004 17:29:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: remove (unneeded proto) that causes a warning w/o CONFIG_PM
Message-ID: <20041021002935.GA13781@taniwha.stupidest.org>
References: <20041020023803.GF8597@taniwha.stupidest.org> <20041020235056.GA16606@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020235056.GA16606@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 04:50:56PM -0700, Greg KH wrote:

> Wait, this patch causes problems if CONFIG_PM is enabled.  Not applied.

does it?  the function is declared before it's called so it should be
ok surely?
