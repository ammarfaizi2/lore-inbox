Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313339AbSDUOK1>; Sun, 21 Apr 2002 10:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313365AbSDUOK0>; Sun, 21 Apr 2002 10:10:26 -0400
Received: from rrcs-sw-24-242-143-126.biz.rr.com ([24.242.143.126]:52744 "HELO
	nawilson.com") by vger.kernel.org with SMTP id <S313339AbSDUOK0>;
	Sun, 21 Apr 2002 10:10:26 -0400
Subject: Re: PATCH] Allow setuid/setgid core files
From: "Neil A. Wilson" <nawilson@nawilson.com>
To: Willy Tarreau <wtarreau@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204210824.g3L8OR720085@ns.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 Apr 2002 09:10:19 -0500
Message-Id: <1019398219.16841.2.camel@bhlm.nawilson.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-04-21 at 03:24, Willy Tarreau wrote:
> BTW, what uid/gid will the core get ? I think that it should get
> the highest level so that if someone breaks in through a service
> which uses this feature and which has dropped its uid/gid, at
> least he cannot read eventual cores from previous attempts.
> Comments ?
> 

Thanks for the feedback.  You bring up a good point here.  Currently the
dump is owned by the effective uid.  I'll look into writing it as root.

Neil


