Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbSJ2OzY>; Tue, 29 Oct 2002 09:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSJ2OzX>; Tue, 29 Oct 2002 09:55:23 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:48035 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S261748AbSJ2OzX>; Tue, 29 Oct 2002 09:55:23 -0500
Date: Tue, 29 Oct 2002 08:01:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mlockall() with MCL_FUTURE
Message-ID: <20021029150141.GD688@opus.bloom.county>
References: <1035940307.2256.25.camel@amol.in.ishoni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035940307.2256.25.camel@amol.in.ishoni.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 08:11:46PM -0500, Amol Kumar Lad wrote:
> Hi,
>   I was just going through its implementation. If mlockall() is invoked
> with MCL_FUTURE, does it mean that all the existing locked mappings of
> process should get unlocked ? Attaching code segment from do_mlockall().
> I am using 2.4.18 kernel

There is a problem here which is fixed in 2.4.19, I believe.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
