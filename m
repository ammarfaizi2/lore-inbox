Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751616AbWJIRmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbWJIRmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWJIRmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:42:09 -0400
Received: from codepoet.org ([166.70.99.138]:9414 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1751616AbWJIRmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:42:08 -0400
Date: Mon, 9 Oct 2006 11:42:06 -0600
From: Erik Andersen <andersen@codepoet.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-kernel-headers-2.6.19-rc1.tar.gz
Message-ID: <20061009174205.GA24502@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <1160032160.26064.17.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160032160.26064.17.camel@pmac.infradead.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 05, 2006 at 08:09:20AM +0100, David Woodhouse wrote:
> A full set of user-visible kernel headers for all supported
> architectures, exported from the 2.6.19-rc1 kernel, has been uploaded
> to
> ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/kernel-headers/snapshot/
> 
> I had planned to do this for 2.6.18 but it wasn't quite in good enough
> shape by then. This one should be fine -- you can build your C library
> against it and ship it in /usr/include. And tell me what breaks...

I'm curious how you produced this for all architectures?  Did you
write up a script to so something trivial like

    for i in $LINUX_DIR/arch/*; do
	make ARCH=$(basename $i) INSTALL_HDR_PATH=/tmp/foo headers_install;
    done

or did you do something more complicated and interesting?  If so,
would you mind sharing?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
