Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWJQShW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWJQShW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWJQSgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:36:49 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:23179 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751383AbWJQSgm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:36:42 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Date: Tue, 17 Oct 2006 21:32:53 +0300
User-Agent: KMail/1.9.5
Cc: kronos.it@gmail.com, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org
References: <20061017180210.GA20287@dreamland.darkstar.lan> <200610172114.30268.ismail@pardus.org.tr> <45351de7.ky2ldiUVUFoikxQ6%Joerg.Schilling@fokus.fraunhofer.de>
In-Reply-To: <45351de7.ky2ldiUVUFoikxQ6%Joerg.Schilling@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610172132.54137.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

17 Eki 2006 Sal 21:16 tarihinde, Joerg Schilling şunları yazmıştı: 
> Ismail Donmez <ismail@pardus.org.tr> wrote:
> > I was just trying a fast hack to see it works ;-) but iso files produced
> > by latest mkisofs works fine even without patching.
>
> Did you _really_ use the latest mkisofs?

Yes :

[~]> ./mkisofs MeGUI-x264_generic_profiles_v31.7z > test.iso
Total translation table size: 0
Total rockridge attributes bytes: 0
Total directory bytes: 0
Path table size(bytes): 10
Max brk space used 21000
176 extents written (0 MB)

[~]> sudo mount -o loop -t iso9660 test.iso ./test

[~]> ls test
megui_x2.7z

[~]> ./mkisofs --version
mkisofs 2.01.01a18 (i686-pc-linux-gnu)
