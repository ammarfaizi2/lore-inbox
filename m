Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293184AbSB1PYw>; Thu, 28 Feb 2002 10:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293445AbSB1PYo>; Thu, 28 Feb 2002 10:24:44 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48162 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293423AbSB1PWl>; Thu, 28 Feb 2002 10:22:41 -0500
Date: Thu, 28 Feb 2002 10:22:24 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Barubary <barubary@cox.net>, linux-kernel@vger.kernel.org,
        Rick Stevens <rstevens@vitalstream.com>
Subject: Re: Big file support
Message-ID: <20020228102224.G8011@redhat.com>
In-Reply-To: <3C7D3587.8080609@vitalstream.com> <006301c1bfc9$a5c6de90$a7eb0544@CX535256D> <20020227223426.N23151@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020227223426.N23151@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Wed, Feb 27, 2002 at 10:34:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 10:34:26PM +0200, Matti Aarnio wrote:
> There are several filesystems which are 64-bit/large-file supporting,
> but also some which are inherently incapable to exceed 2G or 4G.
> 
> It looks like the LOOP driver lands in between -- it should be LFS
> capable, but it isn't.

Loop is LFS capable.  I know that we shipped LFS enabled loop utilities 
for 7.2, probably 7.1 as well.  They were missed in the first batch of 
LFS conversions, and several distributions are lagging behind in this 
area.

		-ben
