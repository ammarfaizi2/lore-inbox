Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266256AbUHFDtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUHFDtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266454AbUHFDtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:49:08 -0400
Received: from holomorphy.com ([207.189.100.168]:17864 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266256AbUHFDtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:49:06 -0400
Date: Thu, 5 Aug 2004 20:48:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@vger.kernel.org, rl@hellgate.ch
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806034859.GQ17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@vger.kernel.org, rl@hellgate.ch
References: <1091754711.1231.2388.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091754711.1231.2388.camel@cube>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi writes:
>> I really wanted /proc/pid/statm to die [1] and I still believe the
>> reasoning is valid. As it doesn't look like that is going to happen,

On Thu, Aug 05, 2004 at 09:11:52PM -0400, Albert Cahalan wrote:
> It would be awful to lose statm, especially since WLI has fixes
> for some of the problems. Just why do you want to kill statm?
> Now quoting from your patch...

Just to cite my own sources, the fixes I had were forward ports of RHAS
patches for statm accounting at the time of pte modification.


-- wli
