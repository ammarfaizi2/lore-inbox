Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288923AbSBMUsa>; Wed, 13 Feb 2002 15:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288919AbSBMUsS>; Wed, 13 Feb 2002 15:48:18 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:14220 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288923AbSBMUsD>;
	Wed, 13 Feb 2002 15:48:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: /proc key naming consistency
Date: Wed, 13 Feb 2002 21:52:36 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020213030047.8B1FB2257B@www.webservicesolutions.com> <a4eh19$lko$1@cesium.transmeta.com>
In-Reply-To: <a4eh19$lko$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16b6OL-0002Q8-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 09:07 pm, H. Peter Anvin wrote:
> Followup to:  <20020213030047.8B1FB2257B@www.webservicesolutions.com>
> By author:    Mark Swanson <swansma@yahoo.com>
> In newsgroup: linux.dev.kernel
> > 
> > Notice the space between "cpu" and "MHz", or "cpu" and "family" yet there
> > is no space between "fdiv" and "bug" (_).
> > 
> > The reason I think NOT using a space is a good idea because it makes life 
> > easier for developers parsing /proc entries. Specifically, Java 
> > developers could use /proc/cpuinfo as a property file, but the space in 
> > the 'key' breaks java.util.Properties.load(). 
> > 
> 
> When I and Dan Quinlan submitted the cleanup for this we used _
> everywhere.  Unfortunately some other people not just added keys with
> spaces, but gracefully "corrected" our "mistakes"...

What do you think about the idea earlier in this thread of going with 
shell-parsable key value pairs?  I find that idea really attractive, but 
there's the issue of breaking utilities (kde control panel?) that already 
parse the existing format.

-- 
Daniel
