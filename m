Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbUKPLDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbUKPLDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 06:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbUKPLDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 06:03:22 -0500
Received: from pauline.vellum.cz ([81.31.2.234]:59349 "EHLO pauline.vellum.cz")
	by vger.kernel.org with ESMTP id S261956AbUKPLC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 06:02:28 -0500
Date: Tue, 16 Nov 2004 12:02:26 +0100
From: Jan Kratochvil 
	<rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: penberg@gmail.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041116120226.A27354@pauline.vellum.cz>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>; from miklos@szeredi.hu on Tue, Nov 16, 2004 at 11:20:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 16, 2004 at 11:20:22AM +0100, Miklos Szeredi wrote:
> >    - Breaks if CONFIG_PROC_FS is not enabled.
> 
> Yes.  Would a device node be better?  Perhaps.  This way there's no
> need to allocate a major/minor for a device.

"fuse/version" you have in /proc while it belongs to /proc
"fuse/dev"     you have in /proc while it belongs to /dev

Also I am not sure human-readable "fuse/version" is required there at all.
Regular FUSE request enlisted in 'enum fuse_opcode' would be enough.


Regards,
Lace
