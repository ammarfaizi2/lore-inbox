Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291971AbSBAU1o>; Fri, 1 Feb 2002 15:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291974AbSBAU1f>; Fri, 1 Feb 2002 15:27:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25875 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291971AbSBAU1Z>; Fri, 1 Feb 2002 15:27:25 -0500
Message-ID: <3C5AFA22.1020208@zytor.com>
Date: Fri, 01 Feb 2002 12:27:14 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Peter Monta <pmonta@pmonta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Monta wrote:

>>Anything that is meant to be a server really pretty much needs an
>>enthropy generator these days.
>>
> 
> Many motherboards have on-board sound.  Why not turn the mic
> gain all the way up and use the noise---surely there will be
> a few bits' worth?
> 
> Perhaps there ought to be a way to give bits to the kernel's
> /dev/random input hopper from user space.
> 


There already is.  If I'm not completely mistaken, just write the raw data
to /dev/random, then there is an ioctl() saying "add N bits to the
entrophy counter."

	-hpa


