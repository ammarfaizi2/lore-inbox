Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262910AbTCKMNO>; Tue, 11 Mar 2003 07:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262911AbTCKMNO>; Tue, 11 Mar 2003 07:13:14 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:2515 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262910AbTCKMNN>; Tue, 11 Mar 2003 07:13:13 -0500
Date: Tue, 11 Mar 2003 13:23:53 +0100
From: =?unknown-8bit?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org, phoebe-list@redhat.com
Subject: Re: Stack growing and buffer overflows
Message-ID: <20030311122353.GA12274@wohnheim.fh-wedel.de>
References: <20030310230012.26391.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030310230012.26391.qmail@linuxmail.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 March 2003 00:00:12 +0100, Felipe Alfaro Solana wrote:
>  
> on x86, the stack grows downwards (from higher memory addresses to
> lower memory addresses). This makes buffer overflows attacks easy to
> exploit: if a function uses strcpy() instead of strncpy() to copy
> data [...]
>  
> However, what would happen if the stack was implemented to grow
> upwards [...]

Stack overflows by mistake would go unnoticed, bad.
Stakc overflows in order to gain root privileges take only little more
effort, no change.

Nothing gained, something lost.

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
