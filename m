Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286190AbRLTH0U>; Thu, 20 Dec 2001 02:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286192AbRLTH0J>; Thu, 20 Dec 2001 02:26:09 -0500
Received: from dsl-213-023-043-155.arcor-ip.net ([213.23.43.155]:55569 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286190AbRLTH0F>;
	Thu, 20 Dec 2001 02:26:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "David S. Miller" <davem@redhat.com>, bcrl@redhat.com
Subject: Re: aio
Date: Thu, 20 Dec 2001 08:27:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: billh@tierra.ucsd.edu, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
In-Reply-To: <20011219190716.A26007@burn.ucsd.edu> <20011219224717.A3682@redhat.com> <20011219.213910.15269313.davem@redhat.com>
In-Reply-To: <20011219.213910.15269313.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16GxcH-0001bB-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 20, 2001 06:39 am, David S. Miller wrote:
>    From: Benjamin LaHaise <bcrl@redhat.com>
>    Date: Wed, 19 Dec 2001 22:47:17 -0500
>    An X server that doesn't have to make a syscall to find out that
>    more data has arrived?
> 
> Who really needs this kind of performance improvement?  Like anyone
> really cares if their window gets the keyboard focus or a pixel over a
> AF_UNIX socket a few nanoseconds faster.  How many people do you think
> believe they have unacceptable X performance right now and that
> select()/poll() syscalls overhead is the cause?  Please get real.

I care, I always like faster graphics.

> People who want graphics performance are not pushing their data
> through X over a filedescriptor, they are either using direct
> rendering in the app itself (ala OpenGL) or they are using shared
> memory for the bulk of the data (ala Xshm or Xv extensions).

You're probably overgeneralizing.  Actually, I run games on my server and 
display the graphics on my laptop.  It works.  I'd be happy if it was faster.

I don't see right off how AIO would make that happen though.  Ben, could you 
please enlighten me, what would be the mechanism?  Are other OSes doing X 
with AIO?

--
Daniel

