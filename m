Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276569AbRI2Rvq>; Sat, 29 Sep 2001 13:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276571AbRI2Rvg>; Sat, 29 Sep 2001 13:51:36 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:17687 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S276569AbRI2Rv3>; Sat, 29 Sep 2001 13:51:29 -0400
Date: Sat, 29 Sep 2001 13:51:56 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lock_kiovec question
Message-ID: <20010929135156.A26140@redhat.com>
In-Reply-To: <3BB58FAF.D1AF2D25@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB58FAF.D1AF2D25@colorfullife.com>; from manfred@colorfullife.com on Sat, Sep 29, 2001 at 11:09:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2001 at 11:09:03AM +0200, Manfred Spraul wrote:
> lock_kiovec tries to lock each page in the kiovec, and fails if it can't
> lock one of the pages.

lock_kiovec is dead code and should be deleted.

		-ben
