Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSG1Sij>; Sun, 28 Jul 2002 14:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSG1Sij>; Sun, 28 Jul 2002 14:38:39 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:17157 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317030AbSG1Sih>; Sun, 28 Jul 2002 14:38:37 -0400
Date: Sun, 28 Jul 2002 19:41:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 11/13] don't hold i_sem during O_DIRECT writes to blockdevs
Message-ID: <20020728194157.A15466@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D439E43.5F2DEE3D@zip.com.au> <20020728120611.A7332@infradead.org> <3D44302C.1082D6DC@zip.com.au> <20020728190544.A14314@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020728190544.A14314@infradead.org>; from hch@infradead.org on Sun, Jul 28, 2002 at 07:05:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 07:05:44PM +0100, Christoph Hellwig wrote:
> And I think we can expect reasonable ulimits for root nowdays, although
> I'm open for discussions on that one.

Forget about this one - I remembered the code wrongly.

