Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311140AbSCHVXR>; Fri, 8 Mar 2002 16:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311135AbSCHVW4>; Fri, 8 Mar 2002 16:22:56 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17393 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S311133AbSCHVWv>; Fri, 8 Mar 2002 16:22:51 -0500
Date: Fri, 8 Mar 2002 16:22:49 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jeff Dike <jdike@karaya.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020308162249.C12425@redhat.com>
In-Reply-To: <20020306205229.A15048@redhat.com> <200203081917.OAA03071@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203081917.OAA03071@ccure.karaya.com>; from jdike@karaya.com on Fri, Mar 08, 2002 at 02:17:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 02:17:53PM -0500, Jeff Dike wrote:
> OK, the patch below (against UML 2.4.18-2) implements reliable overcommit 
> for UML.

Well, I still dislike it, but I guess it'll have to do.  The only nits I see 
about the patch are: could you make the inline function a #define for the 
no-arch_validate case?  Also, the format of if statements is a bit abnormal: 
please add line breaks as appropriate.  Aside from that, go ahead.

		-ben
