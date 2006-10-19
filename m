Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946553AbWJSWCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946553AbWJSWCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946549AbWJSWCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:02:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53679 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946553AbWJSWCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:02:17 -0400
Date: Thu, 19 Oct 2006 15:02:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] Char: mxsers, correct tty driver name
Message-Id: <20061019150212.6c95f6bf.akpm@osdl.org>
In-Reply-To: <3160912811766612133@muni.cz>
References: <3160912811766612133@muni.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 16:10:10 +0200
Jiri Slaby <jirislaby@gmail.com> wrote:

> Mxser tty driver name should be ttyMI, not ttyM. Correct this in both
> drivers (mxser, mxser_new) to avoid conflicts with isicom driver, which is
> ttyM.

Is the mxser.c part needed in mainline?
