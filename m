Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbUCORlY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUCORlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:41:24 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:31562 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262626AbUCORlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:41:22 -0500
Date: Mon, 15 Mar 2004 18:41:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Fabian Fenaut <fabian.fenaut@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1 and -mm2: include/linux/version.h missing (vanilla ok)
Message-ID: <20040315174148.GA2163@mars.ravnborg.org>
Mail-Followup-To: Fabian Fenaut <fabian.fenaut@free.fr>,
	linux-kernel@vger.kernel.org
References: <S262583AbUCOOfF/20040315143505Z+146@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S262583AbUCOOfF/20040315143505Z+146@vger.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 03:35:01PM +0100, Fabian Fenaut wrote:
> Hi,
> 
> Why is there no include/linux/version.h after having compiled -mm1 and -mm2 
> ?
> Compilation of kernel is fine, but because of this, my nvidia modules won't
> compile.
> 
> As said in the subject, 2.6.4 vanilla is ok, version.h is here after
> compilation.
> 
> I use debian woody, and I type
> 
> make-kpkg --append-to-version -ff --revision 1 binary-arch
> make-kpkg --append-to-version -ff --revision 1 modules_image

I dunno make-kpkg, but 'make clean' became a bit more effective in mm1.
So now 'make clean' deletes version.h - maybe that's your problem?

In that case, why are a make clean executed?

	Sam
