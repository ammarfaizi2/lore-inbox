Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262257AbRETWlJ>; Sun, 20 May 2001 18:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbRETWk7>; Sun, 20 May 2001 18:40:59 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46345 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262257AbRETWkt>; Sun, 20 May 2001 18:40:49 -0400
Date: Sun, 20 May 2001 18:03:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105191743000.393-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105201756550.5547-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Mike Galbraith wrote:

> @@ -1054,7 +1033,7 @@
>  				if (!zone->size)
>  					continue;
> 
> -				while (zone->free_pages < zone->pages_low) {
> +				while (zone->free_pages < zone->inactive_clean_pages) {
>  					struct page * page;
>  					page = reclaim_page(zone);
>  					if (!page)


What you're trying to do with this change ? 

