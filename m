Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269259AbUINK4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269259AbUINK4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUINK4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:56:52 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:34984 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S269259AbUINK4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:56:18 -0400
Date: Tue, 14 Sep 2004 12:55:27 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>
Subject: Re: [pidhashing] [2/3] lower PID_MAX_LIMIT for 32-bit machines
Message-ID: <20040914105527.GB11238@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914022530.GO9106@holomorphy.com> <20040914022827.GP9106@holomorphy.com> <20040914023114.GQ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914023114.GQ9106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc2-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 19:31:14 -0700, William Lee Irwin III wrote:
> -#define PID_MAX_LIMIT (4*1024*1024)
> +#define PID_MAX_LIMIT (sizeof(long) > 32 ? 4*1024*1024 : PID_MAX_DEFAULT)

An architecture with sizeof(long) > 32? -- Most impressive.

Roger
