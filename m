Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281171AbRKLABe>; Sun, 11 Nov 2001 19:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281175AbRKLABY>; Sun, 11 Nov 2001 19:01:24 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:55189 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281171AbRKLABS>; Sun, 11 Nov 2001 19:01:18 -0500
Date: Sun, 11 Nov 2001 19:01:14 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFT] final cur of tr based current for -ac8
Message-ID: <20011111190114.A31746@redhat.com>
In-Reply-To: <20011110173331.F17437@redhat.com> <Pine.LNX.4.33.0111111119270.305-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111111119270.305-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Sun, Nov 11, 2001 at 11:58:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 11:58:30AM +0100, Mike Galbraith wrote:
> The below seems to make flogging noises, but is likely too soggy.

Erk, the behaviour of str with your patch isn't quite compatible 
enough for a smooth transition.  What is really needed is to have 
"str" error out or generate the existing strl with a huge warning 
about unspecified type.  Either way the kernel has to work with 
both old and new tools for a brief period of time.

		-ben
