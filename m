Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279629AbRJ2XjL>; Mon, 29 Oct 2001 18:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279628AbRJ2XjA>; Mon, 29 Oct 2001 18:39:00 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:58142 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279629AbRJ2Xiv>; Mon, 29 Oct 2001 18:38:51 -0500
Date: Mon, 29 Oct 2001 18:39:27 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011029183927.J25434@redhat.com>
In-Reply-To: <20011029181527.G25434@redhat.com> <Pine.LNX.4.33.0110291522490.16656-100000@penguin.transmeta.com> <20011029183315.I25434@redhat.com> <20011029.153603.45720857.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011029.153603.45720857.davem@redhat.com>; from davem@redhat.com on Mon, Oct 29, 2001 at 03:36:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 03:36:03PM -0800, David S. Miller wrote:
> It isn't a bug, the referenced bit is a heuristic.  The referenced bit
> being wrong cannot result in corrupted user memory.

We might as well choose what pages to swap out according to a random number 
generator then.

		-ben
-- 
Fish.
