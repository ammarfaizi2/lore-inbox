Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316999AbSEWT5v>; Thu, 23 May 2002 15:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317000AbSEWT5u>; Thu, 23 May 2002 15:57:50 -0400
Received: from imladris.infradead.org ([194.205.184.45]:32271 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316999AbSEWT5u>; Thu, 23 May 2002 15:57:50 -0400
Date: Thu, 23 May 2002 20:57:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: sebastian.droege@gmx.de, hch@infradead.org, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [2.5.17-cset1.656] patch to compile nfs (and maybe others)
Message-ID: <20020523205700.A13631@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, sebastian.droege@gmx.de,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020523182601.19620dbd.sebastian.droege@gmx.de> <20020523173425.A1713@infradead.org> <20020523184141.6fe51ec2.sebastian.droege@gmx.de> <20020523.093601.20619013.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 09:36:01AM -0700, David S. Miller wrote:
>    From: Sebastian Droege <sebastian.droege@gmx.de>
>    Date: Thu, 23 May 2002 18:41:41 +0200
> 
>    Ok... but then we've to copy the FASTCALL stuff (which is used
>    elsewhere too) from linkage.h to namei.h or something else...
> 
> namei.h should include linkage.h and I sent precisely that
> to Linus last evening...

It is pulled in through kernel.h - one of the first headers kernel
sources are expected to include.  Please don't mess up the headers
again, I've spent lots of work to get rid of the horrible header
depencies Linux has.

