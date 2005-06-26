Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVFZFHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVFZFHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 01:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVFZFHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 01:07:44 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:14522 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261528AbVFZFHj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 01:07:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jpxtW1FZ9RaItFBrISbU31ONRdoGk/AxQVR0DGrM3V9JmF6V/ajdUIH/gHnE+vkL6pPDOWTjlZBRXqfEMNkCDgiN0XY+RBM9k1e8R1raxJkuGQext+hbTtrCdia5v8kxubA7Td8OYvepD9Z9Z6jQskRNg1/YyN3dBVRaWhXYsks=
Message-ID: <e692861c05062522071fe380a5@mail.gmail.com>
Date: Sun, 26 Jun 2005 01:07:38 -0400
From: Gregory Maxwell <gmaxwell@gmail.com>
Reply-To: Gregory Maxwell <gmaxwell@gmail.com>
To: Lincoln Dale <ltd@cisco.com>
Subject: Re: reiser4 plugins
Cc: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <42BE3645.4070806@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	 <42BCD93B.7030608@slaphack.com>
	 <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>
	 <42BDA377.6070303@slaphack.com>
	 <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
	 <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/05, Lincoln Dale <ltd@cisco.com> wrote:
> the l-k community have asked YOU may times.  any lack of response isn't
> because of the kernel cabal .. its because YOU are refusing to entertain
> any notion that what Reiser4 has implemented is unpalatable to the
> kernel community.

A lot of this is based on misconceptions, for example in recent times
reiser4 is faulted for layering violations.. But it doesn't have them,
it neither duplicates nor modifies the VFS.

It has also been requested that reiser4 be changed to move some of
it's operations above the VFS... not only would that not make sense
for the currently provided functions, but merging was put off
previously because of changes to the VFS.... now that it doesn't
change the VFS we are asking hans to push it off until it does??

It's a filesysem for gods sake. Hans and his team have worked hard to
minimize its impact and they are still willing to accept more
guidance, even if their patience has started to run a little thin.  
The acceptance of reiser4 into the mainline shouldn't be any larger
deal than any other filesystem, but yet it is...
