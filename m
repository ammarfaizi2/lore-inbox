Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291195AbSAaRof>; Thu, 31 Jan 2002 12:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291196AbSAaRoZ>; Thu, 31 Jan 2002 12:44:25 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:46346 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S291195AbSAaRoS> convert rfc822-to-8bit; Thu, 31 Jan 2002 12:44:18 -0500
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
From: Martin Bahlinger <ry42@rz.uni-karlsruhe.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 31 Jan 2002 18:44:09 +0100
Message-Id: <1012499057.704.0.camel@hek411>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sebastian Dröge wrote:
> Oleg Drokin <green@namesys.com> wrote:
> > Ok, I think we got it. And yes it it was reiserfs fault.
> > What I really cannot understand is how it was working before???
> > Ok, so anybody who sees the oopses should try 2 patches attached.
> > prealloc_init_list_head.diff is just forgotten initialisation
> > and pick_correct_key_version.diff is the real fix.
> > I wonder is anybody will be able to reproduce a bug with these 2
> > fixes
> > (I hope not).
> everything seems to work perfect :)
> my system has booted without any problems

After applying those patches to 2.5.3 I still got an Oops after a
PAP-14030 message. I will try to catch the Oops (have never done this
before, may take some time) and feed it to ksymoops.

bye
  Martin

-- 
Martin Bahlinger <bahlinger@rz.uni-karlsruhe.de>   (PGP-ID: 0x98C32AC5)

