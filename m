Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312691AbSDKRx0>; Thu, 11 Apr 2002 13:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312694AbSDKRxZ>; Thu, 11 Apr 2002 13:53:25 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:22151
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S312691AbSDKRxZ>; Thu, 11 Apr 2002 13:53:25 -0400
Date: Thu, 11 Apr 2002 10:51:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove compiler.h from mmap.c
Message-ID: <20020411175126.GE19157@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.44L.0204111436080.31387-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 02:37:23PM -0300, Rik van Riel wrote:

> compiler.h is included via other include files now and its
> #include has been removed from most C files, this patch
> finishes the job for mm/*

What #include file is mm/mmap.c getting <linux/compiler.h> from now?
Hiding (or relying on indirect) #includes isn't always a good thing...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
