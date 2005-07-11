Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVGKXBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVGKXBA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVGKW7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:59:00 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:48878 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262207AbVGKW6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:58:18 -0400
Message-ID: <42D2F983.1060105@namesys.com>
Date: Mon, 11 Jul 2005 15:58:11 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: David Masover <ninja@slaphack.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<878y0svj1h.fsf@evinrude.uhoreg.ca> <42C4F97B.1080803@slaphack.com> <87ll4lynky.fsf@evinrude.uhoreg.ca> <42CB0328.3070706@namesys.com> <42CB07EB.4000605@slaphack.com> <42CB0ED7.8070501@namesys.com> <42CB1128.6000000@slaphack.com> <42CB1C20.3030204@namesys.com> <42CB22A6.40306@namesys.com> <42CBE426.9080106@slaphack.com> <42D1F06C.9010905@stesmi.com> <42D2DB99.9050307@slaphack.com> <42D2DCA0.1040106@stesmi.com>
In-Reply-To: <42D2DCA0.1040106@stesmi.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:

>
> I think "..." and ".meta" both serve as a logical delimiter. However
> some programs implement their own "..." which would make it clash with
> them. Naturally if some program created a directory called .meta we're
> equally screwed.

I chose '....' (four dots) because it clashes with less, not three dots.
