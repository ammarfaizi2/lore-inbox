Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319081AbSHTOZ2>; Tue, 20 Aug 2002 10:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319091AbSHTOZ2>; Tue, 20 Aug 2002 10:25:28 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:13565 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S319081AbSHTOZ1>; Tue, 20 Aug 2002 10:25:27 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020819223044.A1507@mars.ravnborg.org> 
References: <20020819223044.A1507@mars.ravnborg.org>  <Pine.LNX.4.44.0208161049200.8911-100000@serv> <3D60BA16.38B9CC40@alphalink.com.au> 
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Greg Banks <gnb@alphalink.com.au>, Roman Zippel <zippel@linux-m68k.org>,
       Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Aug 2002 15:28:40 +0100
Message-ID: <26597.1029853720@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sam@ravnborg.org said:
> David suggest to use randomly generated configurations, but they lack
> one important feature. They are always valid, and a new system shall
> be able to deal with hand-edited .config files in the same way as
> oldconfig. 

I suggested those as a way for testing the equivalence of the old and new
rulesets if the language changed. My main objection to CML2 was not the
language itself or the gratuitous use of python, but the fact that the
actual configuration rules were changed in extremely dubious ways.

Think 'provably correct transforms between AndreCode and C'.

You do also want to deal with hand-edited .config files in a similar manner 
to the existing tools, yes -- but that's a different issue.

--
dwmw2


