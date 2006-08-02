Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWHBTxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWHBTxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWHBTxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:53:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:32902 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932208AbWHBTxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:53:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FFQPOyCrx/fBizaUMfhk8HhVOMfECfwBcFWXgvc9r0/HUjbCg3Kk1F2unyf/blriXh92wCZdsBe0z9l3p/my5b6oieO+iDn8CJTFtmYDQ1vr/2KUZouvNVY8FQdae+esEeJH7dqu8z7aGsfz4TOIVeo2fBqmGiZJpgH8Po6YDHg=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: reiser4: maybe just fix bugs?
Date: Wed, 2 Aug 2006 21:53:30 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com> <44CEBCBC.9070707@namesys.com>
In-Reply-To: <44CEBCBC.9070707@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608022153.30788.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 04:30, Hans Reiser wrote:
> Denis Vlasenko wrote:
> > * Are there plans for making reiserfsck interface compatible with fsck?
> >  I mean, making it so that reiserfsck can be symlinked to fsck.reiser
> >  and it will work? Currently, there seems to be some incompatibility
> >  in command-line switches. (I will dig out details and send separately
> >  when I'll get back to my Linux box.)
> 
> Not sure what you mean.  Forgive me, I have not supervised fsck as
> closely as other things.

I just tested. reiserfsck from latest reiserfsprogs is compatible with
fsck. That is, I symlinked reiserfsck to fsck.reiserfs and on reboot
fsck -a ran "fsck.reiserfs <device>" for all my reiser3 partitions.

So this problem doesn't exist anymore. Thanks!

P.S. My fsck is from e2fsprogs-1.34.
--
vda
