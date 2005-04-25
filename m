Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVDYQkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVDYQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVDYQiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:38:19 -0400
Received: from hockin.org ([66.35.79.110]:43940 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262660AbVDYQhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:37:37 -0400
Date: Mon, 25 Apr 2005 09:37:29 -0700
From: Tim Hockin <thockin@hockin.org>
To: Olivier Galibert <galibert@pobox.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050425163729.GA26142@hockin.org>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <20050425094804.GA33040@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425094804.GA33040@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 11:48:04AM +0200, Olivier Galibert wrote:
> Is there a possibility for a process to change its namespace to
> another existing one?  That would be needed to have a per-user
> namespace you go to from rc files or pam.

I haven't looked at this in about a year, but as of a year ago, no.
Namespaces are/were second-class objects that exist only as referenced by
tasks.  I played with implementing a newns PAM module.  It worked, but was
full of holes.  I started writing a paper on it, but never got around to
finishing it, for various reasons.

Tim
