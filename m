Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTJSO7i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 10:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTJSO7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 10:59:38 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:9806 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262057AbTJSO7h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 10:59:37 -0400
Date: Sun, 19 Oct 2003 16:59:14 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproduceable oops in -test8
Message-Id: <20031019165914.4360b3b7.aradorlinux@yahoo.es>
In-Reply-To: <20031019011949.GD711@holomorphy.com>
References: <20031018234848.51a2b723.aradorlinux@yahoo.es>
	<20031019011949.GD711@holomorphy.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 18 Oct 2003 18:19:49 -0700 William Lee Irwin III <wli@holomorphy.com> escribió:

> Two stupid bugs in my case. With a bit of noise surrounding things
> (e.g. EXPORT_SYMBOL() crud, init_task paranoia garbage, ->f_pos in
> unsigned long removal), un-reversing the arguments to find_pid()
> and not blowing away the last-seen tid while formatting it and later
> trying to use it as ->f_pos are the needed fixes.

This fixes the oops in wli1, thanks; now it reproduces the same behaviour
of vanilla -test8
