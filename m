Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266599AbUHCOoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUHCOoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266580AbUHCOoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:44:17 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:13961
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266531AbUHCOoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:44:08 -0400
Message-ID: <410FA44F.1020804@bio.ifi.lmu.de>
Date: Tue, 03 Aug 2004 16:42:23 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dick Streefland <dick.streefland@altium.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
References: <410F481C.9090408@bio.ifi.lmu.de> <64bf.410f9d6f.62af@altium.nl>
In-Reply-To: <64bf.410f9d6f.62af@altium.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick Streefland wrote:
> Frank Steiner <fsteiner-mail@bio.ifi.lmu.de> wrote:
> | Or is there any other way to get an initial console or
> | output any messages from an init script if one boots via nfsroot
> | and  / (and thus, /dev) is only exported read-only from the
> | server?
> 
> You can boot with a ramdisk as root, initialized with an initrd, and
> then perform all NFS mounts manually in the init script. You can use
> pivot_root to switch to an NFS root to get rid of the ramdisk.

I'm hoping for an easier solution, because it's a lot of work just
to get the console messages onto the screen. But maybe I have to go
through this :-)



-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
