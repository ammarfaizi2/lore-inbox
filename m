Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTKFQAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 11:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTKFQAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 11:00:35 -0500
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:40685
	"HELO fargo") by vger.kernel.org with SMTP id S263697AbTKFQAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 11:00:30 -0500
Date: Thu, 6 Nov 2003 17:00:28 +0100
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Using proc in chroot environments
Message-ID: <20031106160028.GA6392@fargo>
Mail-Followup-To: DervishD <raul@pleyades.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20031102204934.GB54@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031102204934.GB54@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ;),

>     I'm using a chroot environment on my main disk as a 'crash test
> dummy', and I need to access the proc filesystem inside it. Since
> hard links are not allowed for directories, the only solution I can
> think of is to mount proc inside the chroot environment just after
> chrooting. This works, I've tested, but I have two problems:

Have you tried the --bind mount option? It's great to solve this kind
of problem, accesing to a directory within a chrooted enviroment. I've
used it successly with a ftp server ;).

-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
