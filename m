Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUITLLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUITLLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUITLLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:11:51 -0400
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:40080
	"HELO fargo") by vger.kernel.org with SMTP id S266257AbUITLKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:10:16 -0400
Date: Mon, 20 Sep 2004 13:11:58 +0200
From: David =?iso-8859-15?Q?G=F3mez?= <david@dervishd.net>
To: Olaf Hering <olh@suse.de>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920111158.GA7228@fargo>
Mail-Followup-To: Olaf Hering <olh@suse.de>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040920094602.GA24466@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olaf ;),

> Andries, /etc/mtab is obsolete since the day when /proc/self/mounts was
> introduced. So, kill it today from your mount binary! TODAY. ...
> 
> Then discuss what is still missing from /proc/self/mounts:

I agree with your approach Olaf. Better _fix_ first mount to remove
totally mtab support, and after put in /proc/self/mount the additional
info that previously only existed in /etc/mtab. Or i'm afraid that
it will never be removed...

Heck, i should learn myself some kernel programming and add the
new options to /proc/self/mounts. I'm really tired of having an
/etc/mtab file in my system...

bye

-- 
David Gómez

"The question of whether computers can think is just like the question of
whether submarines can swim." -- Edsger W. Dijkstra
