Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277564AbRJHWbp>; Mon, 8 Oct 2001 18:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277570AbRJHWbf>; Mon, 8 Oct 2001 18:31:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11795 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277200AbRJHWbZ>; Mon, 8 Oct 2001 18:31:25 -0400
Subject: Re: linux-2.4.10-acX
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Mon, 8 Oct 2001 23:36:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011008152822.A7156@mikef-linux.matchmail.com> from "Mike Fedyk" at Oct 08, 2001 03:28:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qj17-00028g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -	Elevator flow control
> 
> Where can I find more information on this?

Read the ll_rw_blk diff. Basically it tries to avoid too many locked buffers
clogging up memory and killing the box. I'm not totally sure its the
right approach 
