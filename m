Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSHMKdX>; Tue, 13 Aug 2002 06:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSHMKdX>; Tue, 13 Aug 2002 06:33:23 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:62472 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S314546AbSHMKdW>; Tue, 13 Aug 2002 06:33:22 -0400
Date: Mon, 12 Aug 2002 17:20:30 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Message-ID: <20020812172030.A4679@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0208101134510.2197-100000@home.transmeta.com> <3D556101.8080006@mandrakesoft.com> <20020810200116.A15236@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020810200116.A15236@infradead.org>; from hch@infradead.org on Sat, Aug 10, 2002 at 08:01:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 08:01:17PM +0100, Christoph Hellwig wrote:
> Solaris 9 (and Solaris 8 with a certain patch) support Linux-style
> sendfile().  Linux 2.5 on the other hand doesn't support sendfile to
> files anymore..

Why got it broken? It was useful for copying and showing the
progress at the same time without touching the own VM.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
