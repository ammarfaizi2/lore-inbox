Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751964AbWI3UxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbWI3UxK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWI3UxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:53:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41162 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751964AbWI3UxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:53:07 -0400
Date: Sat, 30 Sep 2006 22:52:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       ext-Tuukka.Tikkanen@nokia.com
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core,  Platform Power Parameter 1/2
Message-ID: <20060930205258.GB3061@elf.ucw.cz>
References: <20060930022428.e27d4c53.eugeny.mints@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930022428.e27d4c53.eugeny.mints@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Basic building block for PM Core layer is platform power parameter concept. A platform power parameter is a name, get and set methods.  
> 
> Although an PM Core implementation is completely arch specific any PM Core is
> supposed to utilize platform power parameter concept.
> 
> Also any PM Core is supposed to export names of all platform power parameters
> available on a platform. Any entity which registeres operating points is primary
> consumer of platform_pwr_param_get_names() interface.
> 
> (Probably this interface routine might be moved to be a part of PowerOP Core 
> interface)
> 
> diff --git a/include/linux/plat_pwr_param.h b/include/linux/plat_pwr_param.h
> new file mode 100644
> index 0000000..3a78d2b
> --- /dev/null
> +++ b/include/linux/plat_pwr_param.h

This is generic code (and please select some more reasonable
filename). It should not be in patch marked "OMAP1".

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
