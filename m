Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbUAHS0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUAHS0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:26:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:715 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265680AbUAHS0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:26:17 -0500
Date: Thu, 8 Jan 2004 10:19:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ian Pilcher <i.pilcher@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Checking patch for non-x86 bugs
Message-Id: <20040108101936.41578f55.rddunlap@osdl.org>
In-Reply-To: <3FFD17B5.90603@comcast.net>
References: <3FFD17B5.90603@comcast.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jan 2004 02:41:25 -0600 Ian Pilcher <i.pilcher@comcast.net> wrote:

| I know that this is probably wishful thinking, but "they" always say
| that the only stupid question is the one you don't ask.  (Whoever "they"
| are, they are decidedly wrong about this, BTW.)
| 
| I have a patch that adds an x86-specific sysctl.  I believe that every-
| thing is properly #ifdef'ed, but it would be awful nice to be able to
| ensure that I haven't broken building on non-x86 architectures.  Is
| there any way to do this without building a full-fledged cross-compiler
| toolchain?  (And if not, does anyone know of a good HOWTO on setting up
| such a toolchain?)

You can look at http://www.kegel.com/crosstool/
to see if it can help you.

I'll look at your (previously posted) patch also.

--
~Randy
