Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVALP7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVALP7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVALP7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:59:25 -0500
Received: from binda.bath.ac.uk ([138.38.32.22]:9831 "EHLO binda.bath.ac.uk")
	by vger.kernel.org with ESMTP id S261175AbVALP7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:59:23 -0500
From: Florian Schanda <ma1flfs@bath.ac.uk>
To: Diego Calleja <diegocg@gmail.com>
Subject: Re: [fuse-devel] Merging?
Date: Wed, 12 Jan 2005 15:58:08 +0000
User-Agent: KMail/1.7.2
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <loom.20041231T155940-548@post.gmane.org> <E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <20050112153131.1f778264.diegocg@gmail.com>
In-Reply-To: <20050112153131.1f778264.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121558.10414.ma1flfs@bath.ac.uk>
X-kerberosV-authenticator: ma1flfs@BATH.AC.UK
X-Scanner: 040d4084e443a1344963b70eabd6e86f1445daea
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 January 2005 14:31, Diego Calleja wrote:
> -It could replace gnome-vfs AND kioslaves by a more generic solution that
> works for all environments

kioslaves such as camera, smb, etc.. are obvious to replace (and this has 
already happened from what I can see), and I think are a good idea. We have a 
single mountpoint for these things, for example:
 /camera/mycamera/picture1.png
 /smb/workgroup/computer/share/file.blah

How would you go about replacing a kioslaves which operate "somewhere in the 
middle" (i dunno the correct technical term) such as tar? In other words how 
would tar:/home/foo/bar.tar.bz2/baz/picture.png work with a FUSE (so 
reiserfs4 is not a valid answer to this question) filesystem?

Just some thoughts,

 Florian
