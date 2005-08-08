Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVHHWI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVHHWI6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVHHWI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:08:58 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:31244 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932262AbVHHWI5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:08:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=krVmTbiW0WtZPc0fP/cRSh/UMBFo6Aa/CdSVLR1hPscLAxXBAS/ZajsaFYBQvtmd0sHdfz0Mc/vkDZ+52sQmc7hq5Q0fmqZMMmiVgLNpSSWR4DkLnN0V6KPQy3QIhaygIP1p6bfLUjnzaQgJRfPuOWAQmFo3BnSOJtwpZPUIlxs=
Message-ID: <105c793f050808150810784ef3@mail.gmail.com>
Date: Mon, 8 Aug 2005 18:08:57 -0400
From: Andrew Haninger <ahaning@gmail.com>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Compiling module-init-tools versions after v3.0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm trying to upgrade one of my machines to module-init-tools-3.2-pre8
so that I can better assist a driver developer in debugging some
issues with the OPL3SA2 driver from ALSA.

The machine is currently running a slightly-modified Slackware 9.1
distribution (I've updated several packages to support the 2.6 kernel
and other upgrades since the first install). I currently have
module-init-tools 3.0 installed but I'd like to install version
3.2-pre8.

The problem is that compiling module-init-tools versions after 3.0
seem require docbook-utils (the compile fails on a docbook2man
operation) to be installed and docbook-utils requires jade which will
not compile. I found one jade package called jade-1.2.1 (from '98 or
'99) which will not compile. I tried openjade, but it does not seem to
work when compiling docbook-tools (I made a symlink from the openjade
binary to "jade").

Is there some other package that I'm overlooking that's required to
get docbook-utils installed?  If not, how have other people compiled
and installed newer versions of module-init-tools?

Thanks.

-Andy
