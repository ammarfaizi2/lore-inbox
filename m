Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSCFPY5>; Wed, 6 Mar 2002 10:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293189AbSCFPYo>; Wed, 6 Mar 2002 10:24:44 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:21859 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293599AbSCFPYO>; Wed, 6 Mar 2002 10:24:14 -0500
Date: Wed, 6 Mar 2002 10:24:07 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jeff Dike <jdike@karaya.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020306102407.B22650@redhat.com>
In-Reply-To: <3C84F449.8090404@zytor.com> <200203051812.NAA03363@ccure.karaya.com> <20020305133054.B432@redhat.com> <E16ict0-0002zT-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16ict0-0002zT-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Mar 06, 2002 at 03:59:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 03:59:22PM +0100, Daniel Phillips wrote:
> Suppose you have 512 MB memory and an equal amount of swap.  You start 8
> umls with 64 MB each.  With your and Peter's suggestion, the system always
> goes into swap.  Whereas if the memory is only allocated on demand it
> probably doesn't.

As I said previously, going into swap is preferable over randomly killing 
new tasks under heavy load.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
