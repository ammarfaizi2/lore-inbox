Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136232AbRD0Vok>; Fri, 27 Apr 2001 17:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136233AbRD0Vob>; Fri, 27 Apr 2001 17:44:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41735 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136232AbRD0VoQ>; Fri, 27 Apr 2001 17:44:16 -0400
Date: Fri, 27 Apr 2001 18:44:11 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: LA Walsh <law@sgi.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, <Matt_Domsch@Dell.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <3AE9DC22.597D94F5@sgi.com>
Message-ID: <Pine.LNX.4.33.0104271842550.17635-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, LA Walsh wrote:

>     An interesting option (though with less-than-stellar performance
> characteristics) would be a dynamically expanding swapfile.  If you're
> going to be hit with swap penalties, it may be useful to not have to
> pre-reserve something you only hit once in a great while.

This makes amazingly little sense since you'd still need to
pre-reserve the disk space the swapfile grows into.

A dynamically growing swap file can only save you if you
reserve enough free space on your filesystem for the thing
to grow...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

