Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbUCTNGm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbUCTNGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:06:42 -0500
Received: from vhost-13-248.vhosts.internet1.de ([62.146.13.248]:12476 "EHLO
	spotnic.de") by vger.kernel.org with ESMTP id S263394AbUCTNGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:06:40 -0500
In-Reply-To: <1079738422.7279.308.camel@dhcppc4>
References: <200403181019.02636.ross@datscreative.com.au> <200403191955.38059.thomas.schlichter@web.de>  <405B4893.70701@gmx.de> <1079738422.7279.308.camel@dhcppc4>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4-549145791"
Message-Id: <9B3F281E-7A6F-11D8-8FE4-000A9597297C@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
From: Daniel Egger <de@axiros.com>
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
Date: Sat, 20 Mar 2004 14:07:57 +0100
To: Len Brown <len.brown@intel.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-4-549145791
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 20.03.2004, at 00:20, Len Brown wrote:

> Actually I think it is that we don't _count_ C1 usage.

Are you sure? At least it seems we do in 2.6.4:
active state:            C2
default state:           C1
bus master activity:     00000000
states:
     C1:                  promotion[C2] demotion[--] latency[000] 
usage[00067690]
    *C2:                  promotion[--] demotion[C1] latency[090] 
usage[00673373]
     C3:                  <not supported>

Servus,
       Daniel

--Apple-Mail-4-549145791
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQFxCNTBkNMiD99JrAQJBbwf/bTEBu/HlyiWd+MYl1AhBLlCX4orEQwmn
4FiXKEOJ/4ZvAmhI5WLeVWVlwB8TAAHIoRnw/TQm2mKZO21k1W6kEiQwWFfqVEnw
bpqJyJJ9NRM7hRuoToT6q4RWLwK2qtG8xrsLUOaGByWDeCyqOJKvW2B1uKgGz2Kb
SVZM3MPXRy5uOEQ9eNbm9KfhbAV5raRq8AbybMxaeo65tVn//Py5ciFPp9ETiAOv
idHBDwPId+8vz861qBLRwIprkw7aRK830458UiFTHrtj4DEQbldh1y0OmKC6swe9
EPZIspXKeWyBHzTejLrDuZsCOs1E6XkSSvrGbGa8kmBs2w5v2W9zQA==
=ygtq
-----END PGP SIGNATURE-----

--Apple-Mail-4-549145791--

