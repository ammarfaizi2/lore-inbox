Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUFNOEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUFNOEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUFNOEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:04:00 -0400
Received: from [213.146.154.40] ([213.146.154.40]:16856 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263085AbUFNOD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:03:57 -0400
Date: Mon, 14 Jun 2004 15:03:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040614140356.GA21349@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Cesar Eduardo Barros <cesarb@nitnet.com.br>,
	linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
References: <20040612011129.GD1967@flower.home.cesarb.net> <20040614095529.GA11563@infradead.org> <20040614134652.GA1961@flower.home.cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614134652.GA1961@flower.home.cesarb.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 10:46:52AM -0300, Cesar Eduardo Barros wrote:
> I don't see why preserving the mtime and ctime would be necessary, since
> to move a file away you either don't touch it (using rename) or only
> read and unlink it (to write to a tape or other filesystem, and you can
> save the atime and mtime while doing it). So O_NOATIME is enough for
> both behaviours.

Maybe some day the file needs to come back from the tape ;-)  Or rather
in the HSM scenario a part of the file.

