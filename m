Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSFCKca>; Mon, 3 Jun 2002 06:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSFCKca>; Mon, 3 Jun 2002 06:32:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64664 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317354AbSFCKc2>;
	Mon, 3 Jun 2002 06:32:28 -0400
Date: Mon, 03 Jun 2002 02:27:39 -0700 (PDT)
Message-Id: <20020603.022739.102772773.davem@redhat.com>
To: wli@holomorphy.com
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: remove mixture of non-atomic operations with page->flags which
 requires atomic operations to access
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020603102809.GA912@holomorphy.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Mon, 3 Jun 2002 03:28:09 -0700
   
   It should be clearing it, I'd retransmit if there weren't other objections
   to address...

Such as the fact that none of these operations need to
be atomic :-)
