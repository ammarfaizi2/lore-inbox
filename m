Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293626AbSCFP37>; Wed, 6 Mar 2002 10:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293599AbSCFP3t>; Wed, 6 Mar 2002 10:29:49 -0500
Received: from dsl-213-023-039-135.arcor-ip.net ([213.23.39.135]:7083 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293189AbSCFP3n>;
	Wed, 6 Mar 2002 10:29:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: Wed, 6 Mar 2002 16:24:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Dike <jdike@karaya.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3C84F449.8090404@zytor.com> <E16ict0-0002zT-00@starship.berlin> <20020306102407.B22650@redhat.com>
In-Reply-To: <20020306102407.B22650@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16idH7-0002zc-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 6, 2002 04:24 pm, Benjamin LaHaise wrote:
> On Wed, Mar 06, 2002 at 03:59:22PM +0100, Daniel Phillips wrote:
> > Suppose you have 512 MB memory and an equal amount of swap.  You start 8
> > umls with 64 MB each.  With your and Peter's suggestion, the system always
> > goes into swap.  Whereas if the memory is only allocated on demand it
> > probably doesn't.
> 
> As I said previously, going into swap is preferable over randomly killing 
> new tasks under heavy load.

Huh?  In the example I gave, you will never oom but with your suggestion, you
will always go needlessly go into swap.  I'm suprised that you and Peter are
aguing in favor of wasting resources.

-- 
Daniel
