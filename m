Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVBRR4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVBRR4f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVBRR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:56:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:41453 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261453AbVBRR4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:56:06 -0500
X-Authenticated: #14776911
From: Stefan =?iso-8859-15?q?D=F6singer?= <stefandoesinger@gmx.at>
To: Norbert Preining <preining@logic.at>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Fri, 18 Feb 2005 19:04:16 +0100
User-Agent: KMail/1.7.2
Cc: acpi-devel@lists.sourceforge.net,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <20050218104633.GA28246@gamma.logic.tuwien.ac.at> <20050218133816.GA13745@gamma.logic.tuwien.ac.at>
In-Reply-To: <20050218133816.GA13745@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502181904.17517.stefandoesinger@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Februar 2005 14:38 schrieb Norbert Preining:
> On Fre, 18 Feb 2005, Norbert Preining wrote:
> > I tried:
> >  2.6.11-rc3-mm2 + Xorg + DRI disabled
> > and this works.
> >
> > I cannot enable dri/drm with the cvs version of the drm modules, because
> > the drm modules do not compile for -mm kernels, since there is the patch
> > for multiple agp bridges included (that's the reason why I tried -rc4
>
> Final observation: After patching in the changes from mm kernels for
> multiple agp bridges to the drm-source code (the patch
> drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch from the
> broken out archive) I could compile the drm-trunk-src modules.
>
> So now I am running with 2.6.11-rc3-mm2 + Xorg + DRI enabled (and
> working) with the drm modules from drm-trunk-module-src.
>
> Outcome: freeze when switching to X. As with the other modules (in fact
> I think that most of the changes to the drm stuff are included in the mm
> kernel, so this should not change anything, as mm pulls from bk-agpgart,
> bk-drm-via) a funny screen, and the CapsLock light is blinking.
Kernel panik. Can you ssh into your maschine and get a dmesg? I recommend you 
to write to the dri devs.

Stefan
