Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288821AbSBMUHz>; Wed, 13 Feb 2002 15:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSBMUHp>; Wed, 13 Feb 2002 15:07:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25350 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288821AbSBMUHh>; Wed, 13 Feb 2002 15:07:37 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RFC: /proc key naming consistency
Date: 13 Feb 2002 12:07:05 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a4eh19$lko$1@cesium.transmeta.com>
In-Reply-To: <20020213030047.8B1FB2257B@www.webservicesolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020213030047.8B1FB2257B@www.webservicesolutions.com>
By author:    Mark Swanson <swansma@yahoo.com>
In newsgroup: linux.dev.kernel
> 
> Notice the space between "cpu" and "MHz", or "cpu" and "family" yet there is 
> no space between "fdiv" and "bug" (_).
> 
> The reason I think NOT using a space is a good idea because it makes life 
> easier for developers parsing /proc entries. Specifically, Java developers 
> could use /proc/cpuinfo as a property file, but the space in the 'key' breaks 
> java.util.Properties.load(). 
> 

When I and Dan Quinlan submitted the cleanup for this we used _
everywhere.  Unfortunately some other people not just added keys with
spaces, but gracefully "corrected" our "mistakes"...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
