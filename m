Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268175AbUIAWVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268175AbUIAWVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIAWUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:20:07 -0400
Received: from mail.zelnet.ru ([80.92.97.13]:20437 "HELO zelnet.ru")
	by vger.kernel.org with SMTP id S267968AbUIAWRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:17:23 -0400
Message-Id: <200001310023.e0V0N1dP022186@altair.deep.net>
To: linux-kernel@vger.kernel.org
cc: viro@parcelfarce.theplanet.co.uk
Subject: Re: silent semantic changes with reiser4
X-Mailer: MH-E 7.4.3; nmh 1.1; GNU Emacs 21.3.1
Date: Mon, 31 Jan 2000 01:23:01 +0100
From: Samium Gromoff <deepfire@zelnet.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> Arguments about O_NOFOLLOW on the intermediate stages are bullshit, IMNSHO -
> if they want to make some parts of tree inaccessible, they should simply
> mkdir /tmp/FOAD; chmod 0 /tmp/FOAD; mount --bind /tmp/FOAD <blocked path>
> in the namespace their daemon is running in.  And forget all that crap
> about filtering pathnames and blocking symlinks on intermediate stages
> the latter is obviously worthless without the former since one can simply
> substitute the symlink body in the pathname).

This made me wonder -- why not have a dedicated /dev/noaccess special node
for exactly such patterns of usage?

Yes that`ll made it Linux-specific and such... but hey -- if it saves
someone for for literally (?) no cost why not?

regards, Samium Gromoff
