Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285671AbRLGXiu>; Fri, 7 Dec 2001 18:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285672AbRLGXil>; Fri, 7 Dec 2001 18:38:41 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:41161 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S285671AbRLGXig>;
	Fri, 7 Dec 2001 18:38:36 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15377.21231.897410.355714@napali.hpl.hp.com>
Date: Fri, 7 Dec 2001 15:38:23 -0800
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-ia64@linuxia64.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] Linux 2.4.17-pre6 drm-4.0
In-Reply-To: <4494.1007767210@ocs3.intra.ocs.com.au>
In-Reply-To: <4494.1007767210@ocs3.intra.ocs.com.au>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 08 Dec 2001 10:20:10 +1100, Keith Owens <kaos@ocs.com.au> said:

  Keith> On Fri, 7 Dec 2001 19:38:23 -0200 (BRST), Marcelo Tosatti
  Keith> <marcelo@conectiva.com.br> wrote:
  >> pre6: - direct render for some SiS cards (Torsten Duwe/Alan Cox)

  Keith> IA64 is still using the drm-4.0 code, as are the (possibly
  Keith> obsolete) -ac kernels.  The drm 4.0 makefiles are a pain in
  Keith> the neck and I want to get rid of them asap.  The SiS direct
  Keith> render is only for drm 4.1 so now is a good time to question
  Keith> if 4.0 is still required.

  Keith> How long do people plan to keep drm 4.0 code in their
  Keith> versions of the kernel?

You mean for 2.5?  I don't think there is a good reason to keep
drm-4.0 there.  For 2.4, we should keep it because there might be
folks out there that rely on it.

	--david
