Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUDRBGT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 21:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbUDRBGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 21:06:18 -0400
Received: from holomorphy.com ([207.189.100.168]:21901 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263183AbUDRBGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 21:06:17 -0400
Date: Sat, 17 Apr 2004 18:06:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marc Singer <elf@buici.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040418010616.GT743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417213333.GS743@holomorphy.com> <20040417215257.GA9691@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417215257.GA9691@flea>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 02:33:33PM -0700, William Lee Irwin III wrote:
>> This doesn't match your first response. Anyway, this one is gets
>> scrapped. I guess if swappiness solves it, then so much the better.

On Sat, Apr 17, 2004 at 02:52:57PM -0700, Marc Singer wrote:
> Huh?  Where do you see a discrepency?  I don't think I claimed that
> the test program performance changed.  The noticeable difference is in
> interactivity once the page cache fills.  IMHO, 30 seconds to do a
> file listing on /proc is extreme.

Oh, sorry, it was unclear to me that the test changed anything but
swappiness (i.e. I couldn't tell they included the patch etc.)


-- wli
