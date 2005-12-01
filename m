Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVLARtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVLARtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVLARtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:49:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23981 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932369AbVLARtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:49:31 -0500
Date: Thu, 1 Dec 2005 17:49:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Darrick J. Wong" <djwong@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Luvella McFadden <luvella@us.ibm.com>, AJ Johnson <blujuice@us.ibm.com>,
       Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Mauelshagen@redhat.com
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabledadapters
Message-ID: <20051201174928.GA13196@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Chris McDermott <lcm@us.ibm.com>,
	Luvella McFadden <luvella@us.ibm.com>,
	AJ Johnson <blujuice@us.ibm.com>,
	Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, Mauelshagen@redhat.com
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E359@otce2k03.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E359@otce2k03.adaptec.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 09:21:43AM -0500, Salyzyn, Mark wrote:
> Arjan van de Ven [mailto:arjan@infradead.org] writes:
> > adaptec could just release the source of the enhancement to linux (as
> > the GPL basically requires anyway :)
> 
> Adaptec did, it was called emd! <ouch>

While the project was a total failure in every respect it at least allows
us to have an open description of the format.  Thanks to Adaptec that we
at least have it, although an open spec would have an a lot easier way
to get that information out :)  But honestly just another raid format
is not really something you'll get us excited about, there are far too
many of them already.

If you actually published the raid sequencer code I'm pretty sure someone
would have picked up the shards of the emd project and turned it into
something useful.  I would have loved to play with that kind of thing for
certain.

> I know, a circular argument ... Regardless this burned out three of the
> most talented engineers at Adaptec working on that project. None of them
> will probably ever contribute to Linux again, they are all now
> Luminaries in the FreeBSD community.

I'm pretty happy that we never have to deal with Justin or Scott again,
as it saves a considerable amount of my time.

(and btw, they've been freebsd commiters and core members long before
 adaptec assigned them to do linux work, which probably was a part
 of the cultural problems when dealing with them)
