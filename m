Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWAZHVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWAZHVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 02:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWAZHVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 02:21:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10166 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750798AbWAZHVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 02:21:21 -0500
Subject: Re: [PATCH 4/4] pmap: reduced permissions
From: Arjan van de Ven <arjan@infradead.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: Nix <nix@esperi.org.uk>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       "Jakub Jelinek <jakub@redhat.com> Al Viro" <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <787b0d920601251745n72811696p129396f1279a4a82@mail.gmail.com>
References: <200601222219.k0MMJ3Qg209555@saturn.cs.uml.edu>
	 <1137996654.2977.0.camel@laptopd505.fenrus.org>
	 <787b0d920601230128o5a12513fjae3708e3fb552dca@mail.gmail.com>
	 <1138009305.2977.28.camel@laptopd505.fenrus.org>
	 <787b0d920601230220r5c7df60dk142d1d637ab4ed48@mail.gmail.com>
	 <87r76vrhsj.fsf@amaterasu.srvr.nix>
	 <787b0d920601251745n72811696p129396f1279a4a82@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 08:21:16 +0100
Message-Id: <1138260076.2976.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's bad enough that procps has to suffer the overhead of
> parsing all that nasty text. The thought of every app doing
> that, automatically via gcc+glibc, is truly horrifying.

well it's rare. The %n printf argument is... almost never used. 

