Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285347AbRLXVfQ>; Mon, 24 Dec 2001 16:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbRLXVfG>; Mon, 24 Dec 2001 16:35:06 -0500
Received: from pD9E576B5.dip.t-dialin.net ([217.229.118.181]:17930 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S285347AbRLXVfC>; Mon, 24 Dec 2001 16:35:02 -0500
Date: Mon, 24 Dec 2001 21:34:52 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: jbglaw@lug-owl.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Data sitting and remaining in Send-Q
Message-ID: <20011224213452.A7761@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org
In-Reply-To: <20011224211726.H2461@lug-owl.de> <1062462662.1009226676@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1062462662.1009226676@[195.224.237.69]>; from linux-kernel@alex.org.uk on Mon, Dec 24, 2001 at 08:44:37PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 08:44:37PM -0000, Alex Bligh - linux-kernel wrote:
> > That would give a different result: "functional TCP connections" or
> > "non-functional TCP connections". Mine are between that. If data gets
> > sent in small chunks, everything is fine, but if it's a larger
> > transfer (more than one ethernet frame may transport???), write()
> > stalls (or non-blocking write returns), but data is kept in
> > Send-Q rather than being sent down to the client.
> 
> Just to check the completely obvious:
> 
[...]
> 
> If you have an L3 device (router etc.) in the middle, you can get
> a similar effect if the device does not fragment data correctly
> (for instance the Cisco into ip tunnels bug - now fixed I think),
> or, if you are using PMTU discovery (probably), if some evil device,

Jan,
do you have some DSL Modem in between?

Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
