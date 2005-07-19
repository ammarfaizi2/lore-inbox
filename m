Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVGSOm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVGSOm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 10:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGSOm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 10:42:57 -0400
Received: from everest.sosdg.org ([66.93.203.161]:954 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261370AbVGSOm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 10:42:56 -0400
Date: Tue, 19 Jul 2005 09:42:54 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: [patch] kbuild: make help binrpm-pkg fix
Message-ID: <20050719144254.GA6893@everest.sosdg.org>
Reply-To: coywolf@lovecn.org
References: <20050715013653.36006990.akpm@osdl.org> <2cd57c9005071907214c71fbaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c9005071907214c71fbaa@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 10:21:30PM +0800, Coywolf Qi Hunt wrote:
> On 7/15/05, Andrew Morton <akpm@osdl.org> wrote:
> > 
> > 
> > Changes since 2.6.13-rc2-mm2:
> > 
> > 
> >  git-drm.patch
> >  git-audit.patch
> >  git-input.patch
> >  git-kbuild.patch
> 
> make help br0ken, missing matching `'' for binrpm-pkg.
> 

This fixes kbuild make help binrpm-pkg missing `''.

Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>

--- 2.6.13-rc3-mm1-cy/scripts/package/Makefile~binrpm-pkg-fix	2005-07-19 22:25:27.000000000 +0800
+++ 2.6.13-rc3-mm1-cy/scripts/package/Makefile	2005-07-19 22:25:47.000000000 +0800
@@ -94,7 +94,7 @@ clean-dirs += $(objtree)/tar-install/
 # ---------------------------------------------------------------------------
 help:
 	@echo '  rpm-pkg         - Build the kernel as an RPM package'
-	@echo '  binrpm-pkg      - Build an rpm package containing the compiled kernel
+	@echo '  binrpm-pkg      - Build an rpm package containing the compiled kernel'
 	@echo '                    and modules'
 	@echo '  deb-pkg         - Build the kernel as an deb package'
 	@echo '  tar-pkg         - Build the kernel as an uncompressed tarball'
