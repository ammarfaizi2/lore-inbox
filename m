Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVDDVCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVDDVCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVDDU7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:59:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:484 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261373AbVDDU5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:57:25 -0400
Date: Mon, 4 Apr 2005 21:57:19 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Renate Meijer <kleuske@xs4all.nl>
Cc: Dag Arne Osvik <da@osvik.no>, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Andreas Schwab <schwab@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Kenneth Johansson <ken@kenjo.org>
Subject: Re: Use of C99 int types
Message-ID: <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com> <3821024b00b47598e66f504c51437f72@xs4all.nl> <42511BD8.4060608@osvik.no> <c3057294a216d19047bdca201fc97e2f@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3057294a216d19047bdca201fc97e2f@xs4all.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 10:30:52PM +0200, Renate Meijer wrote:
 
> When used improperly. The #define Al Viro objected to, is 
> objectionable. It's highly
> misleading, as Mr. Viro pointed out. I fail to see where he made 
> comments on stdint.h
> as such.

Comments on stdint.h are very simple: ...fast... type names are misleading
in exactly the same way as that define.  The fact that they are in standard
does not outweight the confusion potential.
