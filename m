Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSFTXsd>; Thu, 20 Jun 2002 19:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315925AbSFTXsc>; Thu, 20 Jun 2002 19:48:32 -0400
Received: from h24-68-93-250.vc.shawcable.net ([24.68.93.250]:5511 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S315921AbSFTXsb>;
	Thu, 20 Jun 2002 19:48:31 -0400
Message-ID: <3D1269B6.90307@bcgreen.com>
Date: Thu, 20 Jun 2002 16:48:06 -0700
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: "Shipman, Jeffrey E" <jeshipm@sandia.gov>,
       inux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: GPL module question
References: <03781128C7B74B4DBC27C55859C9D73809840643@es06snlnt> <3D10AF67.20204@bcgreen.com> <20020619103125.A6759@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think that there's any disagreement between what I said
and what Jeff said. Code that you write is yours to GPL or not
GPL, as you wish.  There are, however functional issues to consider,
like the fact that some people will 'complain' about your not
releasing your  source code, and that some (most?) of the more
common distributions will have issues (either legal or moral)
about including 'closed' code in their distributions.

The simple case is where you're including the drivers with
your hardware on a disk that is entirely free of GPL code.
In that case, you can do whatever the hell you want with
the source code.

To get some of the other advantages of OS code (like community
support for your drivers and easy inclusion in common
distributions), chances are that you'll have to release
the source code.

Jeff V. Merkey wrote:
 > Unless you lift someone's code "whole cloth" and use it, there
 > is no obligation to GPL any of your module code.  Just make certain
 > you stick to exported functions in /proc/ksyms.  If you add functions,
 > and export anything declared "static" in the kernel, then you may
 > have a requirement to GPL any code that touches these areas.
.....

-- 
Stephen Samuel +1(604)736-2266                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

