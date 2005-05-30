Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVE3ObD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVE3ObD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVE3ObD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:31:03 -0400
Received: from smtp06.auna.com ([62.81.186.16]:728 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261608AbVE3Oat convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:30:49 -0400
Date: Mon, 30 May 2005 14:30:46 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
References: <20050504221057.1e02a402.akpm@osdl.org>
	<1115510869l.7472l.0l@werewolf.able.es>
	<1115594680l.7540l.0l@werewolf.able.es> <s5hd5rx2656.wl@alsa2.suse.de>
	<1115936836l.8448l.1l@werewolf.able.es> <s5hvf5nsb2r.wl@alsa2.suse.de>
	<1116331359l.7364l.0l@werewolf.able.es> <s5hll6eoxhf.wl@alsa2.suse.de>
	<1116369585l.8840l.0l@werewolf.able.es> <s5hoeb8sleq.wl@alsa2.suse.de>
	<1117151518l.7637l.0l@werewolf.able.es> <s5his15xaz2.wl@alsa2.suse.de>
	<1117228680l.24619l.0l@werewolf.able.es> <s5h3bs4x2bk.wl@alsa2.suse.de>
In-Reply-To: <s5h3bs4x2bk.wl@alsa2.suse.de> (from tiwai@suse.de on Mon May
	30 15:37:03 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117463446l.7266l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.79] Login:jamagallon@able.es Fecha:Mon, 30 May 2005 16:30:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.30, Takashi Iwai wrote:
> At Fri, 27 May 2005 21:18:00 +0000,
> J.A. Magallon wrote:
> 
> > Which is the correct way to generate a patch against a kernel tree ?
> 
> Sorry, I don't understand "which" in the above question - do you mean
> alsa-kernel tree or what?  We have a git repository, so that the
> latest ALSA patches can be taken...
> 

Sorry for my bad english...

The correct question is: how do I generate a patch against a given kernel,
from the alsa-driver-x.y.z.tar.gz I can download from alsa.org ?
I thought it was enough to diff -ruN the alsa-kernel dir (minus the Documentation
folder) vs the /usr/src/linux-xxxxx/sound folder.
I have seen that there are some scripts in the tarball that install the new
drivers on a given kernel tree via symlinks, but I would like to get just
a patch. I think I will have to diff selected directories, or create
an exclude list... Are there files that are just copied from mainline and do
not change in ALSA tree, or anything can change under alsa-kernel ?

Now that I think of it, if you work against Linus tree,
would it be more correct to diff against 2.6.12-rc5, and then try to apply
to -rc5-mm1 ? 
Whe you do a release, which is your reference, latest stable (2.6.11),
latest rc or latest git ? 

About git, I don't really like the idea of storing a full kernel tree just
to do 'git update' or the like, and use the 'sound' part.

Thanks.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


