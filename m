Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288579AbSAOQty>; Tue, 15 Jan 2002 11:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288986AbSAOQto>; Tue, 15 Jan 2002 11:49:44 -0500
Received: from ns.ithnet.com ([217.64.64.10]:28932 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288579AbSAOQt1>;
	Tue, 15 Jan 2002 11:49:27 -0500
Date: Tue, 15 Jan 2002 17:49:18 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Klaus Meyer <k.meyer@m3its.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: highmem=system killer, 2.2.17=performance killer ?
Message-Id: <20020115174918.11a3bafc.skraw@ithnet.com>
In-Reply-To: <3C445BFC.E373EA04@m3its.de>
In-Reply-To: <3C439E6D.B2B8C5B8@m3its.de>
	<20020115160018.18793569.skraw@ithnet.com>
	<3C445BFC.E373EA04@m3its.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002 17:42:36 +0100
Klaus Meyer <k.meyer@m3its.de> wrote:

> As I just took a look on the output of cat /proc/meminfo i got the idea
> that i'll increase the pysical swap space. (136M before that means >
> highmem).
> astonishing (using Suse kernel 2.4.16): after an increase to 2GB swap
> and
> using 1,5GB of mem the system runs quit a longer time with a good
> performance,
> but starting the copy process leads also to a slow down of the machine.
> Finally i could see that kupdated is suffering.

I was already tempted to suggest you turn off swap completely, as 136 MB in a 2
GB box are somehow useless anyways. I know, I have the same setup (256MB swap).
As this could work without boot, willing to give it a try? Anyway I would very
much suggest to use -pre3.

Regards,
Stephan



