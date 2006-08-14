Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWHNCDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWHNCDn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 22:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWHNCDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 22:03:43 -0400
Received: from web52605.mail.yahoo.com ([206.190.48.208]:49235 "HELO
	web52605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751789AbWHNCDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 22:03:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gBcZ6ZafazLN/4SyM2eoGQMo3s7YxeRBfR55xWkvHqaZg4VFqEUMjTcapQBlIgJD1MuuP5aA4YHk4Pj6CuKA9c72164At6EDcLrgjZQ+XqGLIwrIfcPASfxJRTrIQLM77dtz3NW2wIPRVAVdxjh009a3iPG/BsPABR10p5SKZow=  ;
Message-ID: <20060814020341.27680.qmail@web52605.mail.yahoo.com>
Date: Mon, 14 Aug 2006 12:03:41 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: CIFS & Lockdep warnings
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, sfrench@samba.org,
       Anton Altaparmakov <aia21@cantab.net>
In-Reply-To: <20060813185102.e01898b9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> On Mon, 14 Aug 2006 11:05:03 +1000 (EST)
> Srihari Vijayaraghavan
> <sriharivijayaraghavan@yahoo.com.au> wrote:
> [...] 
> NTFS takes i_mutex inside iprune_mutex.  NTFS
> _should_ be deadlocking
> because of this (iprune_mutex nests inside i_mutex
> on the write() path) but
> somehow it gets away with it.

Yup. An NTFS volume (thro' USB Storage) was also
mounted at that time. (And the copy operation may have
been between NFTS & CIFS volumes)

Thanks


		
____________________________________________________ 
On Yahoo!7 
Photos: Unlimited free storage – keep all your photos in one place! 
http://au.photos.yahoo.com 

