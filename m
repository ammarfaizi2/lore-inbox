Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUAWPQE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266577AbUAWPQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:16:04 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:58632 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S266560AbUAWPPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:15:18 -0500
Date: Fri, 23 Jan 2004 16:20:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make in 2.6.x
Message-ID: <20040123152006.GA2142@mars.ravnborg.org>
Mail-Followup-To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>,
	linux-kernel@vger.kernel.org
References: <20040123145048.B1082@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040123145048.B1082@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 02:50:48PM +0000, Karel Kulhavý wrote:
> Hello
> 
> Is it correct to issue "make bzImage modules modules_install"
> or do I have to do make bzImage; make modules modules_install?

It is today supported that you specify all targets in one line.
The preferred way to do this is to use:

make all modules_install

'all' will build bot default target and modules - and works across
all architectures.

> Is there any documentation where I can read answer to this question?

No, the top-level README could have included this, but does not so today.

	Sam
