Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVCHD4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVCHD4U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVCHDz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 22:55:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17859 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261271AbVCHDzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 22:55:24 -0500
Date: Tue, 8 Mar 2005 03:55:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, mpm@selenic.com, joq@io.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308035503.GA31704@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Paul Davis <paul@linuxaudiosystems.com>, mpm@selenic.com,
	joq@io.com, cfriesen@nortelnetworks.com, chrisw@osdl.org,
	rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307195020.510a1ceb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 07:50:20PM -0800, Andrew Morton wrote:
> 
> So I still have the rt-lsm patch floating about, saying "merge me, merge
> me!".  I'm not sure that the world would end were I to do so.
> 
> Consider this a prod in the direction of those who were pushing
> alternatives ;)

It's still a really bad idea.  You let the magic gid for oracle hugetlb
patch go in with that reasonsing, now ew have relatime-lsm, next we
$CAPABILITY for $FOO and we're headed straight to interface-hell.

