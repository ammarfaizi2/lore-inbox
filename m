Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbSJPX6J>; Wed, 16 Oct 2002 19:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSJPX6J>; Wed, 16 Oct 2002 19:58:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1206 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261491AbSJPX6J>;
	Wed, 16 Oct 2002 19:58:09 -0400
Date: Wed, 16 Oct 2002 16:56:39 -0700 (PDT)
Message-Id: <20021016.165639.92560498.davem@redhat.com>
To: greg@kroah.com
Cc: joe@perches.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [RFC] change format of LSM hooks
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021016234653.GA27285@kroah.com>
References: <20021016185927.GA25475@kroah.com>
	<1034786033.9520.8.camel@localhost.localdomain>
	<20021016234653.GA27285@kroah.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Greg KH <greg@kroah.com>
   Date: Wed, 16 Oct 2002 16:46:53 -0700

   As for using a macro, that doesn't really have any advantages over the
   existing different functions.

GCC compiles it faster :-)

Older GCC's also compile it better, inline processing stunk until the
3.0 era with the tree based inliner.
