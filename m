Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWGDWfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWGDWfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 18:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWGDWfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 18:35:44 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:58248 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S932319AbWGDWfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 18:35:44 -0400
Date: Wed, 5 Jul 2006 00:35:42 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060704223542.GA16828@janus>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <44A9904F.7060207@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A9904F.7060207@wolfmountaingroup.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 03:46:55PM -0600, Jeff V. Merkey wrote:
[...]
> Add a salvagable file system to ext4, i.e. when a file is deleted, you 
> just rename it and move it to a directory called DELETED.SAV and recycle 
> the files as people allocate new ones.  Easy to do (internal "mv" of 
> file to another directory) and modification of the allocation bitmaps.  
> Very simple and will pay off big.  If you need help designing it, just 
> ask me.

Do you have any idea how to undo the effect of rm -rf /bigtree at
the FS level?

I think such an "undelete" feature should be implemented in userspace.
A filesystem which can travel back in time could be useful however.

-- 
Frank
