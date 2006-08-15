Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWHOOhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWHOOhO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWHOOhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:37:13 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:41607 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030314AbWHOOhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:37:12 -0400
Date: Tue, 15 Aug 2006 07:37:09 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Nathan Scott <nathans@sgi.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060815143709.GA21591@tuatara.stupidest.org>
References: <20060808185405.B2528231@wobbly.melbourne.sgi.com> <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com> <20060811083546.B2596458@wobbly.melbourne.sgi.com> <9a8748490608101544n29f863e7o7584ac64f1d4c210@mail.gmail.com> <9a8748490608101552w12822fa6m415a5fb5537c744d@mail.gmail.com> <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com> <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com> <20060814120032.E2698880@wobbly.melbourne.sgi.com> <9a8748490608140049t492742cx7f826a9f40835d71@mail.gmail.com> <20060815190343.A2743401@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815190343.A2743401@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 07:03:43PM +1000, Nathan Scott wrote:

> Its not clear to me where the rename operation happens in all of
> this - does rsync create a local, temporary copy of the file and
> then rename it?

Yes, this is normally how rsync does it.
