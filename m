Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUGaSMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUGaSMY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 14:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUGaSMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 14:12:24 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:35716 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267987AbUGaSMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 14:12:23 -0400
Subject: Re: uid of user who mounts
From: Steve French <smfrench@austin.rr.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1091287308.2337.6.camel@smfhome.smfdom>
References: <1091239509.3894.11.camel@smfhome.smfdom>
	 <20040730190825.7a447429.rddunlap@osdl.org>
	 <1091244841.2742.8.camel@smfhome1.smfdom>
	 <E1BqqGd-0004fX-00@dorka.pomaz.szeredi.hu>
	 <1091287308.2337.6.camel@smfhome.smfdom>
Content-Type: text/plain
Message-Id: <1091297551.1476.3.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 31 Jul 2004 13:12:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the user unmount of mount.cifs user mounts works on Suse
Workstation with their default umount (the minor change I made was to
/sbin/mount.cifs to add the "user=" that Randy suggested to
mount.cifs.c), even though not on my Fedora install, might be something
slightly different about the Fedora umount or some obscure user error.

