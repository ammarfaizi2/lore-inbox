Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbTF1QwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 12:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbTF1QwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 12:52:11 -0400
Received: from mail47-s.fg.online.no ([148.122.161.47]:8169 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP id S265285AbTF1QwI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 12:52:08 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: Mika Liljeberg <mika.liljeberg@welho.com>
Subject: Re: TCP send behaviour leads to cable modem woes
Date: Sat, 28 Jun 2003 19:06:19 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200306272020.57502.svein.ove@aas.no> <200306281604.52876.svein.ove@aas.no> <1056813724.668.23.camel@hades>
In-Reply-To: <1056813724.668.23.camel@hades>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306281906.20222.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

lørdag 28. juni 2003, 17:22, skrev Mika Liljeberg:
> On Sat, 2003-06-28 at 17:04, Svein Ove Aas wrote:
> > Well, it doesn't appear to have any effect.
> > (What is it *supposed* to do? Something about spurious retransmission
> > timeouts, was it?)
>
> Yeah, frto should help if you're seeing unnecessary retransmission
> timeouts caused by delay spikes. It won't do much good if you're also
> losing packets, e.g., due to overflowing the modem buffers. From what I
> gathered from your explanation, the cable link might also be bunching up
> the incoming ACK packets into bursts, each of which causes the sending
> TCP to inject a corresponding burst of new segments into the network. If
> that's what is happening, rate capping is probably more effective. Even
> if you set the rate cap a little high it should mitigate the effects of
> the bursts.
>
> 	MikaL

That Has Been Tried.

Didn't Work (tm).


At this point I'm starting to suspect there's a problem with my ISP. They keep 
saying there isn't, but...

Incidentally, capping the upload speed should be enough, shouldn't it? If it 
isn't then I should probably try that again.

- - Svein Ove Aas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/csL9OlFkai3rMARAobHAKCVxOQLk8u7ivgGO7M7mjQPbjKiRACeJU8s
9AGfL1lSeZ4tXxSnjHYNEwc=
=Do92
-----END PGP SIGNATURE-----

