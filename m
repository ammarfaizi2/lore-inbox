Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271742AbTHDNoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271743AbTHDNoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:44:18 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:29444 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271742AbTHDNoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:44:18 -0400
Date: Mon, 4 Aug 2003 15:44:15 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: FS: hardlinks on directories
Message-ID: <20030804134415.GA4454@win.tue.nl>
References: <20030804141548.5060b9db.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804141548.5060b9db.skraw@ithnet.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 02:15:48PM +0200, Stephan von Krawczynski wrote:

> although it is very likely I am entering (again :-) an ancient discussion I
> would like to ask why hardlinks on directories are not allowed/no supported fs
> action these days.

Quite a lot of software thinks that the file hierarchy is a tree,
if you wish a forest.

Things would break badly if the hierarchy became an arbitrary graph.


