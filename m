Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbTFWBdb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 21:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264802AbTFWBdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 21:33:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11651 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264801AbTFWBdb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 21:33:31 -0400
Date: Mon, 23 Jun 2003 02:47:36 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop.c - part 1 of many
Message-ID: <20030623014736.GN6754@parcelfarce.linux.theplanet.co.uk>
References: <UTC200306230127.h5N1RpE13973.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200306230127.h5N1RpE13973.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 03:27:51AM +0200, Andries.Brouwer@cwi.nl wrote:

> -static int figure_loop_size(struct loop_device *lo)
> +static int
> +figure_loop_size(struct loop_device *lo)

Please, don't.  See recent flamewar re conversion from K&R style -
splitting declaration before function name is a Bad Thing(tm).
