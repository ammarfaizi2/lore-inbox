Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWBMRaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWBMRaz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWBMRay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:30:54 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:63243 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932370AbWBMRax convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:30:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CseGlFJl/gEUV5mjoIrEmZLF3L0gTiRKTn0Hfy3gWGOIA7yp7SnQWWVbV/xbci8rhXawe4IJkd/HfL1Jr5dLkBXOt67dkWnU4KbUeEKiNPTetJ7Irs2jlmqxgC99ceZRYI/YyKeUEKUqwPsBBU+B9oniV5pLKHxZMLYpPUWJ1Hc=
Message-ID: <d120d5000602130930y31c431c0h2ead3dca814f3a5d@mail.gmail.com>
Date: Mon, 13 Feb 2006 12:30:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rc3: more regressions
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, Dave Jones <davej@redhat.com>,
       Meelis Roos <mroos@linux.ee>, linux-input@atrey.karlin.mff.cuni.cz,
       Claudio Martins <ctpm@rnl.ist.utl.pt>,
       Mark Fasheh <mark.fasheh@oracle.com>, kurt.hackel@oracle.com,
       ocfs2-devel@oss.oracle.com
In-Reply-To: <20060213170945.GB6137@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <20060213170945.GB6137@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Adrian Bunk <bunk@stusta.de> wrote:
>
> Subject    : psmouse starts losing sync in 2.6.16-rc2
> References : http://lkml.org/lkml/2006/2/5/50
> Submitter  : Meelis Roos <mroos@linux.ee>
> Status     : unknown

Working on various manifestations of this one. At worst we will have
to disable resync by default before 2.6.16 final is out and continue
in 2.6.17 cycle.

--
Dmitry
