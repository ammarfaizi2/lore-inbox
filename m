Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWEQAQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWEQAQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWEQAQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:23 -0400
Received: from main.gmane.org ([80.91.229.2]:47298 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932295AbWEQAPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:15:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: replacing X Window System !
Date: Wed, 17 May 2006 01:15:21 +0100
Message-ID: <yw1x7j4l1p7q.fsf@agrajag.inprovide.com>
References: <FC7F4950D2B3B845901C3CE3A1CA6766012A9E6F@mxnd200-9.si-aubi.siegenia-aubi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: agrajag.inprovide.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:oktSved77B1AQ6LRX4Bd3Vgd0xc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Döhr, Markus ICC-H" <Markus.Doehr@siegenia-aubi.com> writes:

>> > First of all, your assumptions are incorrect.  Modern versions of X 
>> > are not old, unoptimised, will do remote sessions, etc.
>> 
>> Remote sessions have been there as long as the DISPLAY 
>> environment variable - I think even X10.4, 2 decades and more 
>> ago, could do that.  I know that it worked just fine 18 years 
>> ago with X11R1 (aah... building that from source on a 25mz
>> Sun3 took a little while). (Anybody know when the first 
>> instance of pointing 'xmelt' at another user's machine for 
>> amusement was? :)
> [...]
>
> Although one has to admit that working with remote X terminals over
> a SSH/WAN/VPN-connection is far from usefull,

It depends on what programs you run.  Emacs runs perfectly fine over a
slow modem.  Firefox is usually very unhappy even on a fast LAN.  In
general, applications that render an image locally and send that to
the X server for display will run badly over a remove connection.
Apps that send text and drawing commands to the server, and let it
take care of rendering run quite well.

> Microsoft´s RDP protocol does a much better job there. However,
> there´s NX (http://www.nomachine.com/) and other products but out of
> the box X11 it´s quite slow over higher latency connections.

RDP is more like VNC, AFAIK.  It serves a different purpose.

-- 
Måns Rullgård
mru@inprovide.com

