Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267293AbUHDHBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267293AbUHDHBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 03:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUHDHBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 03:01:04 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:20453
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267293AbUHDHBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 03:01:01 -0400
Message-ID: <411089A8.8070104@bio.ifi.lmu.de>
Date: Wed, 04 Aug 2004 09:00:56 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
References: <410F481C.9090408@bio.ifi.lmu.de> <64bf.410f9d6f.62af@altium.nl> <ceouv0$7s8$2@news.cistron.nl> <41108380.6080809@bio.ifi.lmu.de> <20040804064716.GA31600@traveler.cistron.net>
In-Reply-To: <20040804064716.GA31600@traveler.cistron.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:

> Assuming you have a way to reproduce this, to the NFS client
> maintainer - see the file MAINTAINERS in the kernel source.

Thanks! I will do so.

> 
> But I just tried to reproduce this on 2.6.7-rc2 (it's what my
> workstation happens to be running) and I can't. I can mount an
> nfs-exported /dev from both 2.4 and 2.6 servers read-only and
> I can open devices on that read-only mount just fine.

It happens only when the server exports the fs read-only. When it
exports the fs rw and you mount it ro on the client, it works. But
with exporting ro, it fails.

Before I report this, I guess I should try 2.6.8-rc3 and see if it
works there.

Thanks!
cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

