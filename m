Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWJITuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWJITuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWJITuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:50:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47808 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964784AbWJITuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:50:04 -0400
Subject: Re: [ANNOUNCE] linux-kernel-headers-2.6.19-rc1.tar.gz
From: David Woodhouse <dwmw2@infradead.org>
To: andersen@codepoet.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061009174205.GA24502@codepoet.org>
References: <1160032160.26064.17.camel@pmac.infradead.org>
	 <20061009174205.GA24502@codepoet.org>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 20:50:02 +0100
Message-Id: <1160423402.7920.15.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 11:42 -0600, Erik Andersen wrote:
> 
> I'm curious how you produced this for all architectures?  Did you
> write up a script to so something trivial like
> 
>     for i in $LINUX_DIR/arch/*; do
>         make ARCH=$(basename $i) INSTALL_HDR_PATH=/tmp/foo
> headers_install;
>     done
> 
> or did you do something more complicated and interesting?  If so,
> would you mind sharing? 

make headers_install_all

-- 
dwmw2

