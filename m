Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUAOSbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 13:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUAOSbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 13:31:31 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:41881 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S265163AbUAOSba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 13:31:30 -0500
Date: Thu, 15 Jan 2004 19:31:25 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Valdis.Kletnieks@vt.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: True story: "gconfig" removed root folder...
Message-ID: <20040115183125.GA5772@cambrant.com>
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv> <87ptdl2q7l.fsf@asmodeus.mcnaught.org> <slrnc0dct5.2o5.erik@bender.home.hensema.net> <20040115160759.GA5458@cambrant.com> <200401151617.i0FGHW1a005870@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401151617.i0FGHW1a005870@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 11:17:32AM -0500, Valdis.Kletnieks@vt.edu wrote:
> That's not fixing the problem, it's moving it around the filesystems.
> 

Would it really? If we use /usr/src/linux (for example) to store
the code of one single kernel and have a user with permission to
write to /usr/src/linux and not to /usr/src, then he couldn't
remove /usr/src, but only /usr/src/linux, right?

I'm not sure if I understand you correctly, and you might mean
that the problem in make gconfig isn't fixed. That's true, but
I'm not the maintainer so I'm just trying to help you find a
solution that will work for now.


                Tim Cambrant
