Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbSIWOZV>; Mon, 23 Sep 2002 10:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbSIWOZV>; Mon, 23 Sep 2002 10:25:21 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:57255
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S261807AbSIWOZU>; Mon, 23 Sep 2002 10:25:20 -0400
Date: Mon, 23 Sep 2002 07:29:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Remco Post <r.post@sara.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38 on ppc/prep
Message-ID: <20020923142951.GO726@opus.bloom.county>
References: <692386AC-CEEC-11D6-A08A-000393911DE2@sara.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692386AC-CEEC-11D6-A08A-000393911DE2@sara.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 02:03:02PM +0200, Remco Post wrote:

> after some tiny fixes to reiserfs and the makefile for prep bootfile 
> (using ../lib/lib.a vs. ../lib/libz.a) I managed to succesfully compile 
> a kernel. It even boots to the point where it frees unused kernel memory 
> and then stops... this includes succesfully mounting the root 
> filesystem...

What typo exactly?  The only 'lib' in the Makefile
(arch/ppc/boot/prep/Makefile) is:
LIBS = ../lib/zlib.a

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
