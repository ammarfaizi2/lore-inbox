Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265586AbRFVXk1>; Fri, 22 Jun 2001 19:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbRFVXkR>; Fri, 22 Jun 2001 19:40:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:60943 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265586AbRFVXkI>; Fri, 22 Jun 2001 19:40:08 -0400
Date: Fri, 22 Jun 2001 19:06:21 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Tom Vier <tmv5@home.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac17
In-Reply-To: <20010622184040.A765@zero>
Message-ID: <Pine.LNX.4.21.0106221901020.1466-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jun 2001, Tom Vier wrote:

> On Fri, Jun 22, 2001 at 09:06:42AM +0200, Mike Galbraith wrote:
> > It's not actually swapping unless you see IO (si/so).  It's allocating
> > swap space, but won't send pages out to disk unless there's demand. One
> 
> if it's pre-allocation, why does it show up as "used"? 
> "reserved" would be a better fit.

You're right. Its just that nobody fixed the code yet.
 


