Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUFGXX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUFGXX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbUFGXX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:23:27 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:43228 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265127AbUFGXX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:23:26 -0400
Date: Mon, 7 Jun 2004 16:23:19 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Hal Nine <hal9@cyberspace.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Flushing the swap
Message-ID: <20040607232319.GA6209@taniwha.stupidest.org>
References: <200406072234.SAA07853@grex.cyberspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406072234.SAA07853@grex.cyberspace.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 06:34:59PM -0400, Hal Nine wrote:

> Is there any way of making linux flush out all pages out of swap
> space?  I want to have 0K of used swap space.

as about 314 people already said 'swapoff -a' will work, but more to
the point is you probably don't want 0K of swap
