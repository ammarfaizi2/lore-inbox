Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTENBtC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTENBtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:49:01 -0400
Received: from holomorphy.com ([66.224.33.161]:23743 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261651AbTENBtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:49:00 -0400
Date: Tue, 13 May 2003 19:01:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Shawn <core@enodev.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: odd db4 error with 2.5.69-mm4 [was Re: Huraaa for 2.5]
Message-ID: <20030514020140.GH8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Shawn <core@enodev.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>
References: <1052866461.23191.4.camel@www.enodev.com> <20030514012731.GF8978@holomorphy.com> <1052877161.3569.17.camel@www.enodev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052877161.3569.17.camel@www.enodev.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 08:52:41PM -0500, Shawn wrote:
> The following is what strace shows. A full trace is attached.
> select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
> select(0, NULL, NULL, NULL, {3, 0})     = 0 (Timeout)
> select(0, NULL, NULL, NULL, {6, 0})     = 0 (Timeout)
> select(0, NULL, NULL, NULL, {9, 0})     = 0 (Timeout)

Could you send me an strace of a successful run?


-- wli
