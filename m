Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbTKGWST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTKGWRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:17:45 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:42763 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263954AbTKGJBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:01:25 -0500
Date: Fri, 7 Nov 2003 10:35:02 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Using proc in chroot environments
Message-ID: <20031107093502.GY275@DervishD>
References: <20031102204934.GB54@DervishD> <20031106160028.GA6392@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031106160028.GA6392@fargo>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi David :)

 * David <david@pleyades.net> dixit:
> >     I'm using a chroot environment on my main disk as a 'crash test
> > dummy', and I need to access the proc filesystem inside it. Since
> > hard links are not allowed for directories, the only solution I can
> > think of is to mount proc inside the chroot environment just after
> > chrooting. This works, I've tested, but I have two problems:
> Have you tried the --bind mount option? It's great to solve this kind
> of problem, accesing to a directory within a chrooted enviroment. I've
> used it successly with a ftp server ;).

    I haven't tried, but I'm afraid it won't solve my problem. First,
if I do a 'binded' mount of /proc, any change in the chrooted proc
will reflect in the original one, so I'm in trouble anyway. Second,
if I do 'mount' or 'cat /proc/mounts' the proc filesystem will be
shown twice anyway (correct me here if I'm wrong).

    By now I'm going to keep using two independent mounts until I
find a better approach... Thanks for your answer :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
