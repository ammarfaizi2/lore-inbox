Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272439AbTHEFPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 01:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272442AbTHEFPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 01:15:21 -0400
Received: from holomorphy.com ([66.224.33.161]:6274 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272439AbTHEFPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 01:15:17 -0400
Date: Mon, 4 Aug 2003 22:16:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Konold <martin.konold@erfrakon.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interactive Usage of 2.6.0.test1 worse than 2.4.21
Message-ID: <20030805051631.GQ32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Konold <martin.konold@erfrakon.de>,
	linux-kernel@vger.kernel.org
References: <200308050704.22684.martin.konold@erfrakon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308050704.22684.martin.konold@erfrakon.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 07:04:22AM +0200, Martin Konold wrote:
> when using  2.6.0.test1 on a high end laptop (P-IV 2.2 GHz, 1GB RAM) I notice 
> very significant slowdown in interactive usage compared to 2.4.21.
> The difference is most easily seen when switching folders in kmail. While 
> 2.4.21 is instantaneous 2.6.0.test1 shows the clock for about 2-3 seconds.
> I am using maildir folders on reiserfs.
> Can anyone verify this behaviour?
> What other information do you need?

CPU profiles, e.g.
readprofile -n -m /boot/System.map-`uname -r` | sort -rn -k 1,1 | head -25

Also logs of vmstat 1.

-- wli
