Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266433AbSLJAVl>; Mon, 9 Dec 2002 19:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbSLJAVk>; Mon, 9 Dec 2002 19:21:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22284 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266433AbSLJAVk>; Mon, 9 Dec 2002 19:21:40 -0500
Message-ID: <3DF53549.9080403@zytor.com>
Date: Mon, 09 Dec 2002 16:28:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
References: <9633612287A@vcnet.vc.cvut.cz> <20021206090234.GA1940@zaurus>	<3DF4DEC0.3030800@zytor.com>	<20021209182605.GA22747@atrey.karlin.mff.cuni.cz> 	<at2qin$fgn$1@cesium.transmeta.com> <1039480856.12051.14.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> I'd rather keep it as is. We should be doing IFS partition with quoting,
> UTF-8 awareness according to locale and locale specific rules on
> whitespace. That says "userspace" all over it. 
> 

Actually, I would argue we definitely should *not*.

	-hpa

