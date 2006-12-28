Return-Path: <linux-kernel-owner+w=401wt.eu-S933018AbWL1Qf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933018AbWL1Qf0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 11:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932948AbWL1Qf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 11:35:26 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:33799 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932839AbWL1QfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 11:35:25 -0500
Date: Thu, 28 Dec 2006 17:26:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Layton <jlayton@redhat.com>
cc: Benny Halevy <bhalevy@panasas.com>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <4593E8CC.8090401@redhat.com>
Message-ID: <Pine.LNX.4.61.0612281725340.23545@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> 
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>  <20061221185850.GA16807@delft.aura.cs.cmu.edu>
  <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
 <1166869106.3281.587.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>
 <4593DEF8.5020609@panasas.com> <4593E8CC.8090401@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 28 2006 10:54, Jeff Layton wrote:
>
> Sorry, I should qualify that statement. A lot of filesystems don't have
> permanent i_ino values (mostly pseudo filesystems -- pipefs, sockfs, /proc
> stuff, etc). For those, the idea is to try to make sure we use 32 bit values
> for them and to ensure that they are uniquely assigned. I unfortunately can't
> do much about filesystems that do have permanent inode numbers.

Anyway, this could probably come in handy for unionfs too.


	-`J'
-- 
