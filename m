Return-Path: <linux-kernel-owner+w=401wt.eu-S967785AbWLIKsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967785AbWLIKsA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 05:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967784AbWLIKsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 05:48:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47271 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967788AbWLIKr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 05:47:59 -0500
Date: Sat, 9 Dec 2006 11:47:58 +0100
From: Jan Kara <jack@suse.cz>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061209104758.GA10261@atrey.karlin.mff.cuni.cz>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> <4578465D.7030104@cfl.rr.com> <1165541892.1063.0.camel@sebastian.intellilink.co.jp> <20061208164206.GA1125@torres.l21.ma.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061208164206.GA1125@torres.l21.ma.zugschlus.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Dec 08, 2006 at 10:38:12AM +0900, Fernando Luis Vázquez Cao wrote:
> > Does the patch below help?
> > 
> > http://marc.theaimsgroup.com/?l=linux-ext4&m=116483980823714&w=4
> 
> No, pkgcache.bin still getting corrupted within two hours of using
> 2.6.19.
  Hmm, interesting. I'll try to reproduce the problem. In the mean time
- does mounting the filesystem with data=writeback help?

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
