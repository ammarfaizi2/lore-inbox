Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263129AbTCLKAw>; Wed, 12 Mar 2003 05:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263132AbTCLKAv>; Wed, 12 Mar 2003 05:00:51 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:14598 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263129AbTCLKAu>; Wed, 12 Mar 2003 05:00:50 -0500
Date: Wed, 12 Mar 2003 10:11:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Torsten Foertsch <torsten.foertsch@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.19] How to get the path name of a struct dentry
Message-ID: <20030312101133.A9312@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Torsten Foertsch <torsten.foertsch@gmx.net>,
	linux-kernel@vger.kernel.org
References: <200303121033.08560.torsten.foertsch@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303121033.08560.torsten.foertsch@gmx.net>; from torsten.foertsch@gmx.net on Wed, Mar 12, 2003 at 10:33:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 10:33:05AM +0100, Torsten Foertsch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> Assuming I have got a particular (struct dentry*)dp, how can I get it's full 
> path name.

You can't.  See d_path() for the information needed to get an absolute path.
