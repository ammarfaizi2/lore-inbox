Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129611AbQKHWTO>; Wed, 8 Nov 2000 17:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129957AbQKHWTD>; Wed, 8 Nov 2000 17:19:03 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:26189
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129611AbQKHWS5>; Wed, 8 Nov 2000 17:18:57 -0500
Date: Wed, 8 Nov 2000 23:11:11 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: malloc(1/0) ??
Message-ID: <20001108231111.D622@jaquet.dk>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKEEAJLMAA.davids@webmaster.com> <Pine.LNX.4.21.0011080149010.32613-100000@server.serve.me.nl> <8ucj2m$oiq$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <8ucj2m$oiq$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Nov 08, 2000 at 02:11:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 02:11:34PM -0800, H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.4.21.0011080149010.32613-100000@server.serve.me.nl>
> By author:    Igmar Palsenberg <maillist@chello.nl>
> In newsgroup: linux.dev.kernel

[snip]

> > May I remind you guys that a malloc(0) is equal to a free(). There is no
> > way that any mem get's malloced. 
> > 
> 
> Where the heck did you get idea?
> 
> 	-hpa

Probably from the malloc man page where it is stated that *realloc* 
with size 0 equals free :)
-- 
        Rasmus(rasmus@jaquet.dk)

Which is worse: Ignorance or Apathy?
Who knows? Who cares?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
