Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288928AbSANJaX>; Mon, 14 Jan 2002 04:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288930AbSANJaM>; Mon, 14 Jan 2002 04:30:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11924 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288928AbSANJ37>;
	Mon, 14 Jan 2002 04:29:59 -0500
Date: Mon, 14 Jan 2002 01:28:31 -0800 (PST)
Message-Id: <20020114.012831.44983761.davem@redhat.com>
To: ebiederm@xmission.com
Cc: riel@conectiva.com.br, akropel1@rochester.rr.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18pre3-ac1
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <m1y9j1pf6r.fsf@frodo.biederman.org>
In-Reply-To: <Pine.LNX.4.33L.0201140409260.32617-100000@imladris.surriel.com>
	<m1y9j1pf6r.fsf@frodo.biederman.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: ebiederm@xmission.com (Eric W. Biederman)
   Date: 14 Jan 2002 00:25:16 -0700
   
   But for make -j the forking is done by make and it is nearly a
   fork bomb

Someone has probably mentioned this, but it is important to recognize
that make uses vfork().
