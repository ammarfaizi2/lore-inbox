Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264120AbRFDGpa>; Mon, 4 Jun 2001 02:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264121AbRFDGpU>; Mon, 4 Jun 2001 02:45:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33544 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264120AbRFDGpC>; Mon, 4 Jun 2001 02:45:02 -0400
Subject: Re: [patch] for irda/irlan
To: tedu@stanford.edu (Ted Unangst)
Date: Mon, 4 Jun 2001 07:42:37 +0100 (BST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.GSO.4.31.0106031814480.16465-100000@elaine15.Stanford.EDU> from "Ted Unangst" at Jun 03, 2001 06:25:09 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156o4T-0005A0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this patch addresses a few issues.  one is unreversed effects in the
> function upon an error condition.  second is a large struct on the stack.
> this code could be called multiple times i believe, making it fairly
> dangerous.  it's fairly inconvenient to move it off the stack, with the
> number of possible error returns, but i think i covered everything.

Please feed these through the Irda maintainers - the irda stack in Linus
tree is way out of date and the one in -ac is a chunk behind right now.
