Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263930AbRFRLuo>; Mon, 18 Jun 2001 07:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263931AbRFRLuf>; Mon, 18 Jun 2001 07:50:35 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:53516 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263930AbRFRLuT>; Mon, 18 Jun 2001 07:50:19 -0400
Date: Mon, 18 Jun 2001 13:50:18 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Client receives TCP packets but does not ACK
Message-ID: <20010618135018.A12320@artax.karlin.mff.cuni.cz>
In-Reply-To: <27525795B28BD311B28D00500481B7601F1477@ftrs1.intranet.ftr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <27525795B28BD311B28D00500481B7601F1477@ftrs1.intranet.ftr.nl>; from f.v.heusden@ftr.nl on Fri, Jun 15, 2001 at 02:53:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > TCP is NOT a guaranteed protocol -- you can't just blast data from one
> port
> > to another and expect it to work.
> 
> Isn't it? Are you really sure about that? I thought UDP was the
> not-guaranteed-one and TCP was the one guaranting that all data reaches the
> other end in order and all. Please enlighten me.

It's "hlaf guaranteed." It guarantees, that if data are delivered to the
reciever, all data sent before already arived and in correct order. But it's
not guaranteed that data succesuly writen on 1 end actualy arived unless the
connection was correctly shutdown and closed. 

Btw: can the aplication somehow ask the tcp/ip stack what was actualy acked?
(ie. how many bytes were acked).

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
