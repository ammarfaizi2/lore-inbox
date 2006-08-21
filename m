Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWHUSgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWHUSgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWHUSgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:36:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50604 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750709AbWHUSgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:36:54 -0400
Date: Tue, 22 Aug 2006 00:06:21 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 0/7] CPU controller - V1
Message-ID: <20060821183621.GA24431@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <1156156960.7772.38.camel@Homer.simpson.net> <20060821124830.GB14291@in.ibm.com> <1156180241.6582.69.camel@Homer.simpson.net> <20060821164553.GA21130@in.ibm.com> <1156192388.6665.29.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156192388.6665.29.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 08:33:08PM +0000, Mike Galbraith wrote:
> Looks ok to me.  Everything except sync && cpu == this_cpu checks.

Hmm ..yes ..stupid of me. !sync will catch the case I had in mind.

-- 
Regards,
vatsa
