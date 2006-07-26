Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWGZP0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWGZP0b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWGZP0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:26:31 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7400 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S1751210AbWGZP0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:26:30 -0400
Message-ID: <44C77B8A.7090303@namesys.com>
Date: Wed, 26 Jul 2006 08:26:18 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Russell Cattelan <cattelan@thebarn.com>, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org>	 <44C26F65.4000103@namesys.com> <44C28A8F.1050408@garzik.org>	 <44C32348.8020704@namesys.com> <1153854781.5893.5.camel@xenon.msp.redhat.com> <44C6AE9E.6020300@slaphack.com>
In-Reply-To: <44C6AE9E.6020300@slaphack.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>
>
>Although I should mention, Hans, that there is a really good reason to
>prefer the 15 minute patches.  The patches that take a week are much
>harder to read during that week than any number of 15 minute incremental
>patches, because the incremental patches are already broken down into
>nice, small, readable, ordered chunks.  And since development follows
>some sort of logical, orderly pattern, it can be much easier to read it
>that way than to try to consider the whole.
>  
>
No, I disagree, if the code is well commented, it is easier to read the
whole thing at the end when it has its greatest coherence and
refinement.  A problem with Reiser4 is that its core algorithms are
simply complex.  We pushed the envelope in multiple areas all at once.
Benchmarks don't always suggest simple algorithms are the ones that will
be highest performance.  Tree algorithms are notorious in the database
industry for being simple on web pages but complex as code.

Some people program in small increments, some program things that
require big increments of change, both kinds of people are needed.
