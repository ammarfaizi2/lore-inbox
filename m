Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270992AbRIWPyo>; Sun, 23 Sep 2001 11:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271569AbRIWPye>; Sun, 23 Sep 2001 11:54:34 -0400
Received: from [200.203.199.88] ([200.203.199.88]:46600 "HELO netbank.com.br")
	by vger.kernel.org with SMTP id <S270992AbRIWPyY>;
	Sun, 23 Sep 2001 11:54:24 -0400
Date: Sun, 23 Sep 2001 12:53:56 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH *] page aging fixed, 2.4.9-ac14
Message-ID: <Pine.LNX.4.33L.0109231251070.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I've made a new page aging patch, this time against 2.4.9-ac14;
this one has two added features over the patch against 2.4.9-ac12:

1) uses min()/max() for smaller page_age_{up,down} functions

2) if we have no free shortage, don't waste CPU time trying
   to enforce the inactive target but rely on background
   scanning only

You can get the patch (a bit large for email) at:

   http://www.surriel.com/patches/2.4/2.4.9-ac14-aging

Please apply for the next 2.4.9-ac kernel, thanks.

regards,


Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

