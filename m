Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSFXQIW>; Mon, 24 Jun 2002 12:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSFXQIV>; Mon, 24 Jun 2002 12:08:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43230 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314381AbSFXQIV>;
	Mon, 24 Jun 2002 12:08:21 -0400
Date: Mon, 24 Jun 2002 09:02:06 -0700 (PDT)
Message-Id: <20020624.090206.44274295.davem@redhat.com>
To: roy@karlsbakk.net
Cc: jes@trained-monkey.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: acenic >4gig sendfile problem
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206241755.00082.roy@karlsbakk.net>
References: <3D05204B.4010103@us.ibm.com>
	<m3r8iwvgl8.fsf@trained-monkey.org>
	<200206241755.00082.roy@karlsbakk.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
   Date: Mon, 24 Jun 2002 17:54:59 +0200

   sendfile() doesn't support >4gig anyway - does it?
   that's the (yet unimplemented) sendfile64()

Nothing to do with file offsets.  It has to do with what physical page
the file data ends up in which can be anywhere.
