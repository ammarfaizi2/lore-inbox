Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUHMTSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUHMTSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUHMTRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:17:24 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:16157 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266905AbUHMTOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:14:42 -0400
Date: Fri, 13 Aug 2004 21:17:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Aloni <da-x@colinux.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Benno <benjl@cse.unsw.edu.au>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] #2 (Generation of *.s files from *.S files in kbuild)
Message-ID: <20040813191704.GA9328@mars.ravnborg.org>
Mail-Followup-To: Dan Aloni <da-x@colinux.org>,
	Sam Ravnborg <sam@ravnborg.org>, Benno <benjl@cse.unsw.edu.au>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040812192535.GA20953@callisto.yi.org> <20040813003743.GF30576@cse.unsw.edu.au> <20040813050424.GA7417@mars.ravnborg.org> <20040813080941.GA7639@callisto.yi.org> <20040813092426.GA27895@callisto.yi.org> <20040813183347.GA9098@mars.ravnborg.org> <20040813190953.GA14504@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813190953.GA14504@callisto.yi.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 10:09:53PM +0300, Dan Aloni wrote:
> > The .S -> .s is used for assembly.
> 
> Actually the only rule I saw that is being used for 
> assembly is the .S -> .o rule (examples under 
> arch/i386/kernel).

Meant to be used if someone do:
make arch/i386/crypto/aes-i586-asm.s

to see the preprocessed version of the .S file.
It's not used in the normal build process.

	Sam
