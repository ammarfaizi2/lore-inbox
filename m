Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288008AbSAHMvY>; Tue, 8 Jan 2002 07:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288007AbSAHMvP>; Tue, 8 Jan 2002 07:51:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:29966 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S288008AbSAHMvD>; Tue, 8 Jan 2002 07:51:03 -0500
Date: Tue, 8 Jan 2002 10:47:05 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@redhat.com>
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        hch@ns.caldera.de (Christoph Hellwig), perex@suse.cz (Jaroslav Kysela),
        sound-hackers@zabbo.net, linux-sound@vger.rutgers.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
Message-ID: <20020108124705.GA1336@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@redhat.com>, torvalds@transmeta.com (Linus Torvalds),
	alan@lxorguk.ukuu.org.uk (Alan Cox),
	hch@ns.caldera.de (Christoph Hellwig),
	perex@suse.cz (Jaroslav Kysela), sound-hackers@zabbo.net,
	linux-sound@vger.rutgers.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20020107181038.GB1026@conectiva.com.br> <200201080213.g082DTD26512@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201080213.g082DTD26512@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 07, 2002 at 09:13:29PM -0500, Alan Cox escreveu:
> > One ring^Wlayout to rule them all <stops here ;)> I would not be unhappy if
> > drivers/net became net/drivers, etc 8)
> 
> Then where do you put the drivers categorized in other ways (multifunction
> devices like i2o for example) ?

misc? Nah, too much work for little gain, and Linus is not willing to
accept patches for such a big change, even if it was interesting, so I think
that the approach you suggested (i.e. sound/{core,oss,alsa}, drivers/sound)
is the way to go.

- Arnaldo
