Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTLHTXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTLHTXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:23:35 -0500
Received: from holomorphy.com ([199.26.172.102]:52700 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261332AbTLHTXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:23:33 -0500
Date: Mon, 8 Dec 2003 11:23:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Volkov <Andrew.Volkov@transas.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: possible proceses leak
Message-ID: <20031208192328.GN8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrew Volkov <Andrew.Volkov@transas.com>,
	linux-kernel@vger.kernel.org
References: <2E74F312D6980D459F3A05492BA40F8D0391B0EE@clue.transas.com> <20031208185121.GM8039@holomorphy.com> <Pine.LNX.4.58.0312081109200.13236@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312081109200.13236@home.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, William Lee Irwin III wrote:
>> Heh, no wonder everyone wants to get rid of the things.

On Mon, Dec 08, 2003 at 11:09:41AM -0800, Linus Torvalds wrote:
> No, they are all correct. No bug here, move along folks, nothing to see..
> 		Linus

Looks like I missed that bit of preempt magic the first time around
the need_resched: path in entry.S. Easy enough to drop this one.


-- wli
