Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSFQF1E>; Mon, 17 Jun 2002 01:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSFQF1D>; Mon, 17 Jun 2002 01:27:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49810 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316746AbSFQF1B>;
	Mon, 17 Jun 2002 01:27:01 -0400
Date: Sun, 16 Jun 2002 22:22:01 -0700 (PDT)
Message-Id: <20020616.222201.105585133.davem@redhat.com>
To: willy@debian.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Remove SCSI_BH
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020616192253.Q9435@parcelfarce.linux.theplanet.co.uk>
References: <20020616192253.Q9435@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Sun, 16 Jun 2002 19:22:53 +0100
   
   Hi, Linus.  This patch switches SCSI from a bottom half to a tasklet.
   It's been reviewed, tested & approved by Andrew Morton, James Bottomley &
   Doug Gilbert.  Please apply.

I always wanted to make this a per-cpu SOFTIRQ, there is no reason
it can't be and it's important enough to deserve to be one.
