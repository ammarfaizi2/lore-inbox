Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314404AbSEBNWo>; Thu, 2 May 2002 09:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314407AbSEBNWn>; Thu, 2 May 2002 09:22:43 -0400
Received: from ns.suse.de ([213.95.15.193]:25105 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314404AbSEBNWj>;
	Thu, 2 May 2002 09:22:39 -0400
Date: Thu, 2 May 2002 15:22:37 +0200
From: Dave Jones <davej@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dwmw2@infradead.org
Subject: Re: Linux 2.5.7
Message-ID: <20020502152237.H16935@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dwmw2@infradead.org
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com> <3CD0FC0E.5020108@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 10:42:54AM +0200, Martin Dalecki wrote:

 > -   struct request *current_request;
 > +   struct request *req;
 >     unsigned int res = 0;
 >     struct mtd_info *mtd;

This gratuitous change makes life a lot more irritating when bring
forward fixes from 2.4. They now need an extra pass to go through
and munge all the varnames. Or are you proposing the same change
for 2.4 ?
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
