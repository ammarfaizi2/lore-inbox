Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311532AbSCTEOG>; Tue, 19 Mar 2002 23:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311554AbSCTENT>; Tue, 19 Mar 2002 23:13:19 -0500
Received: from renoir.op.net ([207.29.195.4]:10501 "EHLO renoir.op.net")
	by vger.kernel.org with ESMTP id <S311532AbSCTEMg>;
	Tue, 19 Mar 2002 23:12:36 -0500
Message-Id: <200203200412.XAA07872@renoir.op.net>
To: Zenaan Harkness <zen@getsystems.com>
cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] Re: Playback stutters 
In-Reply-To: Your message of "Wed, 20 Mar 2002 15:05:03 +1100."
             <20020320150503.A31328@getsystems.com> 
Date: Tue, 19 Mar 2002 23:15:12 -0500
From: Paul Davis <pbd@Op.Net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am getting the same with stock 2.4.18, DELL Inspiron laptop (Maestro
>3i), my test is:
>
>copy a cd image file from one partition to another, while trying to play
>an mp3 using mpg123.
>
>The mp3 skips all over the place.

since you almost certainly have IDE drivers, have you configured them
correctly using hdparm? these are source of considerable scheduling
latency, in ways that AFAIK are not improved by any of the "latency
reducing" patches available. don't ask me how to configure them - i
only use SCSI drives - but a quick google search should reveal
relevant advice.

--p
