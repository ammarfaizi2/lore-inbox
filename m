Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbSLISMa>; Mon, 9 Dec 2002 13:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSLISMa>; Mon, 9 Dec 2002 13:12:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17935 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265894AbSLISM3>; Mon, 9 Dec 2002 13:12:29 -0500
Message-ID: <3DF4DEC0.3030800@zytor.com>
Date: Mon, 09 Dec 2002 10:19:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
References: <9633612287A@vcnet.vc.cvut.cz> <aslmtl_im_1@cesium.transmeta.com> <20021206090234.GA1940@zaurus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Why can't we simply have /bin/bash_that_splits_args_itself
> ?
> 				Pavel

We could, but it would in practice mean doing an extra exec() for each
executable.  This seems undesirable.

	-hpa

