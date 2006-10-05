Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWJET0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWJET0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWJET0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:26:31 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:22199 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1750899AbWJET0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:26:30 -0400
Date: Thu, 5 Oct 2006 21:26:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dennis Heuer <dh@triple-media.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sunifdef instead of unifdef
Message-ID: <20061005192629.GB20742@uranus.ravnborg.org>
References: <20061005183830.351a0a2f.dh@triple-media.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005183830.351a0a2f.dh@triple-media.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, there are three main reasons why I pledge for sunifdef
> compatibility:
> 
> 1. There is a project page and an inviting community
> 2. There is HTML documentation
> 3. They use autotools, which is distributor and administrator-friendly

You do realize that unifdef is included in the kernel so
it just works?

> gcc -O2 -m64   -c -o unifdef.o unifdef.c
> unifdef.c: In function 'main':
> unifdef.c:129: warning: incompatible implicit declaration of built-in
> function 'exit'
> unifdef.c:157: warning: incompatible implicit declaration of built-in
> function 'exit'
> unifdef.c:180: warning: incompatible implicit declaration of built-in
> function 'exit'
> gcc unifdef.o -o unifdef
Patches appreciated - seems a simple #include is missing.

	Sam
