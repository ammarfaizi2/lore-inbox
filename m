Return-Path: <linux-kernel-owner+w=401wt.eu-S965136AbXABXkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbXABXkS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbXABXkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:40:17 -0500
Received: from main.gmane.org ([80.91.229.2]:60766 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965136AbXABXkP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:40:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Steve Youngs <steve@youngs.au.com>
Subject: Re: Nothing since 2.6.19 will boot for me.
Date: Wed, 03 Jan 2007 09:39:42 +1000
Organization: Linux Users - Fanatics Dept.
Message-ID: <microsoft-free.87bqlhkngh.fsf@youngs.au.com>
References: <microsoft-free.87odphsx40.fsf@youngs.au.com>
	<459a93ff$0$335$e4fe514c@news.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Complaints-To: usenet@sea.gmane.org
Keywords: kernel,video,lilo,boot
X-Gmane-NNTP-Posting-Host: 203-206-170-37.perm.iinet.net.au
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Mail-Copies-To: never
X-X-Day: Only 2430508 days till X-Day.  Got Slack?
X-URL: <http://www.youngs.au.com/~steve/>
X-Request-PGP: <http://www.youngs.au.com/~steve/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Now-Playing: The Sounds of Silence --- [Marcel Marceau]
X-Discordian-Date: Pungenday, the 3rd day of Chaos, 3173. 
X-Attribution: SY
User-Agent: Gnus/5.110006 (No Gnus v0.6) SXEmacs/22.1.7 (De Lorean, linux)
Cancel-Lock: sha1:cn2TCzmM/wNdYHGCfFAccgTFLJk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
NotDashEscaped: You need GnuPG to verify this message

* Paul Slootman <paul+nospam@wurtel.net> writes:

  > Steve Youngs  <steve@youngs.au.com> wrote:
  >> 
  >> The last kernel from Linus' tree[1] that boots for me is v2.6.19.  And
  >> before I take my first stab at git-bisect, I thought I'd ask here in
  >> case it's just a PEBCAK.
  >> 
  >> What happens in kernels since v2.6.19 is:
  >> 
  >> o Choose the kernel to boot from lilo menu
  >> 
  >> o Lilo prints the first 2 lines of it's output
  >> 
  >> imagename.....................................
  >> Bios data something or other (sorry, too quick for me to catch
  >> what it actually says)
  >> 
  >> o At this point the machine reboots (right back to the video card
  >> copyright/splash)

  > What is your boot string?

Kernel command line: BOOT_IMAGE=Linus-git-old ro root=302 video=vesafb:mtrr:3,ywrap,1024x768-24

That's not the string from the non-bootable kernels of course, but the
only difference is the image name. (yes, I've tried without the
`video=...') 

  > It sounds a lot like http://bugzilla.kernel.org/show_bug.cgi?id=7505

It looks similar, but I'm seeing different symptoms.  I don't see any
errors, and earlyprintk doesn't print anything.  The machine just
reboots after lilo outputs `BIOS data thing'.

-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|                   Te audire no possum.                   |
|             Musa sapientum fixa est in aure.             |
|----------------------------------<steve@youngs.au.com>---|
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: The SXEmacs Project <http://www.sxemacs.org>
Comment: Eicq - The SXEmacs ICQ Client <http://www.eicq.org/>

iEYEARECAAYFAkWa7T8ACgkQHSfbS6lLMAORZwCgq0ilo4SreYTifPZALt3AdQPs
HIgAnRAFO6BJdZiTaUztExdgm5uimJts
=3vmj
-----END PGP SIGNATURE-----

