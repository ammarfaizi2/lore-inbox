Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTLVS2D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTLVS2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:28:03 -0500
Received: from users.ccur.com ([208.248.32.211]:33717 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S261775AbTLVS1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:27:50 -0500
Date: Mon, 22 Dec 2003 13:26:37 -0500
From: Joe Korty <joe.korty@ccur.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: atomic copy_from_user?
Message-ID: <20031222182637.GA2659@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <1072054100.1742.156.camel@cube> <20031222150026.GD27687@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222150026.GD27687@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 07:00:26AM -0800, William Lee Irwin III wrote:
> c.f. kmap_atomic() usage in mm/filemap.c

Shouldn't the dec_prempt_count() in kunmap_atomic() be followed
by a preempt_check_resched()???

Joe
