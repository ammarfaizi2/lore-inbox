Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261821AbTCaTOP>; Mon, 31 Mar 2003 14:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbTCaTOP>; Mon, 31 Mar 2003 14:14:15 -0500
Received: from to-telus.redhat.com ([207.219.125.105]:41966 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261821AbTCaTOO>; Mon, 31 Mar 2003 14:14:14 -0500
Date: Mon, 31 Mar 2003 14:25:36 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Janet Morgan <janetmor@us.ibm.com>, akpm@digeo.com, suparna@in.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] Retry based aio read - filesystem read changes
Message-ID: <20030331142536.J20730@redhat.com>
References: <20030305144754.A1600@in.ibm.com> <20030305150026.B1627@in.ibm.com> <20030305024254.7f154afc.akpm@digeo.com> <20030305174452.A1882@in.ibm.com> <3E8889B4.FB716506@us.ibm.com> <20030331191123.GB13178@holomorphy.com> <20030331141629.I20730@redhat.com> <20030331191735.GC13178@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030331191735.GC13178@holomorphy.com>; from wli@holomorphy.com on Mon, Mar 31, 2003 at 11:17:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 11:17:35AM -0800, William Lee Irwin III wrote:
> I won't get in the way then. I just watch for things related to what I've
> touched to make sure it isn't going wrong for anyone.

Longer term, I think you've got the right idea: we need to keep more 
statistics on io waits, as right now from a profiling point of view, any 
process that is blocked on io doesn't provide meaningful data to the 
profiler.

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
