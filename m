Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVCKWyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVCKWyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVCKWue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:50:34 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:34459 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261805AbVCKWrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:47:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ad7MRuXf+/O3piqM8cquP2XdPN77TS5YcTt4xW7NKoXYO3U3Xr/BQNGprH9EpzTe+H4/N5q7hM151H5Jst+PVXMux5Jw3LYXq8aZ5a1pKkZwouqNAlZPJppP3ExyUkyJipKM80w1uV2hYh6E/fC1sWcTe32zmkwidJLHonsisEk=
Message-ID: <d120d5000503111447727d7b6@mail.gmail.com>
Date: Fri, 11 Mar 2005 17:47:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: AGP bogosities
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Dave Jones <davej@redhat.com>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <d120d50005031114422c144bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <20050311021248.GA20697@redhat.com>
	 <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org>
	 <87vf7xg72s.fsf@devron.myhome.or.jp>
	 <d120d50005031114422c144bcf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005 17:42:46 -0500, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi,
> 
> On Sat, 12 Mar 2005 07:18:19 +0900, OGAWA Hirofumi
> <hirofumi@mail.parknet.co.jp> wrote:
> >
> > +       if (!atomic_read(v)) {
> > +               printk("BUG: atomic counter underflow at:\n");
> > +               dump_stack();
> > +       }
> 
> I wonder if adding "unlikely" might be beneficial here.

Oh, it's just a debugging patch, nevermind...

-- 
Dmitry
