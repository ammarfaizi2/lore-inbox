Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270992AbRHTBoH>; Sun, 19 Aug 2001 21:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270993AbRHTBnz>; Sun, 19 Aug 2001 21:43:55 -0400
Received: from member.michigannet.com ([207.158.188.18]:12553 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S270992AbRHTBnp>; Sun, 19 Aug 2001 21:43:45 -0400
Date: Sun, 19 Aug 2001 21:43:22 -0400
From: Paul <set@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 [I] just run xdos
Message-ID: <20010819214322.D1315@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com> <m166bjokre.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m166bjokre.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Aug 19, 2001 at 02:30:29PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com>, on Sun Aug 19, 2001 [02:30:29 PM] said:
[...]
> There are a number of cases, where dosemu is different enough it has
> been known to cause code to go down buggy non-common paths and cause
> things to fail.  This has happened with both X and the kernel.
> I suspect that is what is happening here.
> 
> Paul is dosemu configured to do any direct hardware access?
> 
> Also of interest is that this crash is not even directly triggered by
> the dosemu process.  Instead an interrupt handler is doing something
> bad.  
> 
> Paul If you can verify that dosemu isn't doing any direct hardware
> access.  i.e. Dosemu isn't suid root, and you have no ports lines
> you should be fine.
> 
> Eric
> 
	Dear Eric;

	No, the program isnt setuid, nor run by root, and no
ports specified in the config. Let me know if there is anything
further I can do.

Paul
set@pobox.com

