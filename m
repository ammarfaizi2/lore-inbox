Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318641AbSIKKKG>; Wed, 11 Sep 2002 06:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318643AbSIKKKG>; Wed, 11 Sep 2002 06:10:06 -0400
Received: from colin.muc.de ([193.149.48.1]:64012 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S318641AbSIKKKE>;
	Wed, 11 Sep 2002 06:10:04 -0400
Message-ID: <20020911121438.20537@colin.muc.de>
Date: Wed, 11 Sep 2002 12:14:38 +0200
From: Andi Kleen <ak@muc.de>
To: Oleg Drokin <green@namesys.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, ak@muc.de,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre6
References: <Pine.LNX.4.44.0209101501200.16518-100000@freak.distro.conectiva> <20020911140047.A924@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <20020911140047.A924@namesys.com>; from Oleg Drokin on Wed, Sep 11, 2002 at 12:00:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 12:00:47PM +0200, Oleg Drokin wrote:
> Hello!
> 
> On Tue, Sep 10, 2002 at 03:04:04PM -0300, Marcelo Tosatti wrote:
> 
> AGP stuff still does not work for me. (It broke somewhere around 2.4.20-pre4
> and I reported it at that time, but nobody was interested in that somehow)

Does the kernel print a message like "Advanced speculative caching feature present" 
or not present at boot up? 

If yes does it go away when you boot with unsafe-gart-alias  ? 

What other command line options do you use? Perhaps mem=nopentium? If yes
does it help when you boot without that and with unsafe-gart-alias specified.


-Andi
