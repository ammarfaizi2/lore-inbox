Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269736AbTGaV41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269913AbTGaV41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:56:27 -0400
Received: from holomorphy.com ([66.224.33.161]:43993 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269736AbTGaVyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:54:21 -0400
Date: Thu, 31 Jul 2003 14:55:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O11int for interactivity
Message-ID: <20030731215523.GH15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200307301038.49869.kernel@kolivas.org> <1059553792.548.2.camel@teapot.felipe-alfaro.com> <200307301040.38858.m.c.p@wolk-project.de> <20030731214314.GG15452@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731214314.GG15452@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 02:43:14PM -0700, William Lee Irwin III wrote:
> Could you make sure that you're not using 1A? (vanilla 1 and 1B are
> both fine for these purposes).
> Also, can I get a before/after of the following during an mp3 skip test?
> vmstat 1 | tee -a vmstat.log
> n=1; while true; do /usr/sbin/readprofile -n -m /boot/System.map-`uname -r` | sort -k 2,2 > profile.log.$n; n=$(( $n + 1 )); sleep 1; done
> 
> If you could stop the logging shortly after the skip in the kernel that
> does skip (but not _too_ shortly after, give it at least 1 second) I
> would be much obliged. The "before" picture is most important. An
> "after" picture might also be helpful, but isn't strictly necessary.

Please don't forget to boot with profile=1


-- wli
