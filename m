Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbUADVfM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbUADVfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:35:12 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:39869 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S265128AbUADVfF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:35:05 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: 2.6.0-rc1-mm1
Date: Sun, 04 Jan 2004 22:17:33 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.01.04.21.17.28.696467@smurf.noris.de>
References: <20031231004725.535a89e4.akpm@osdl.org>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1073251053 5317 192.109.102.39 (4 Jan 2004 21:17:33 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sun, 4 Jan 2004 21:17:33 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-rc1/2.6.0-rc1-mm1/

Again, available via Bitkeeper at <bk://smurf.bkbits.net/linux-2.6-mm>.

If you use this tree, please consider dropping me a note or whatever;
I don't like to work in a vacuum...

The way I've built this, in case anybody's curious:
- undo all the changes in 2.6.0-mm2 but not in 2.6.1-rc1-mm1.
- merge with 2.6.1-rc1, resolved nine conflicts.
- Apply all patches in 2.6.1-rc1-mm2 but not in 2.6.0-mm2.
  Some didn't apply fully, for whatever reason.
- Generate a diff between 2.6.1-rc1 and top-of-tree.
  Use interdiff -p1 to compare that to Andrew's official patch.
  (There were none, which was somewhat surprising.)

Oh yes, I've stopped prefixing the patch tags with mm[12]; that would get
too confusing in the long run.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Hope is a good breakfast, but it is a bad supper.
		-- Francis Bacon

