Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262218AbSJQWn3>; Thu, 17 Oct 2002 18:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262253AbSJQWn2>; Thu, 17 Oct 2002 18:43:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4288 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262218AbSJQWn2>;
	Thu, 17 Oct 2002 18:43:28 -0400
Date: Thu, 17 Oct 2002 15:41:38 -0700 (PDT)
Message-Id: <20021017.154138.130141726.davem@redhat.com>
To: james@and.org
Cc: matti.aarnio@zmailer.org, zilvinas@gemtek.lt, linux-kernel@vger.kernel.org
Subject: Re: sendfile(2) behaviour has changed ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <m3it00zt4d.fsf@code.and.org>
References: <20021016091046.GD9644@mea-ext.zmailer.org>
	<20021016.025935.132073102.davem@redhat.com>
	<m3it00zt4d.fsf@code.and.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Antill <james@and.org>
   Date: 17 Oct 2002 16:51:30 -0400

    It really needs a new interface for recvfile/copyfile/whatever
   anyway, as you can only specify an off_t for the from fd at present.
   
Ummm, you can use lseek() on the 'to' fd perhaps?
