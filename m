Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbTCMOEr>; Thu, 13 Mar 2003 09:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262330AbTCMOEr>; Thu, 13 Mar 2003 09:04:47 -0500
Received: from sith.mimuw.edu.pl ([193.0.96.4]:56581 "EHLO sith.mimuw.edu.pl")
	by vger.kernel.org with ESMTP id <S262324AbTCMOEr>;
	Thu, 13 Mar 2003 09:04:47 -0500
Date: Thu, 13 Mar 2003 15:15:30 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Patch for initrd on 2.4.21-pre5
Message-ID: <20030313151530.C2850@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030313005328.A29160@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.20 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003, Pete Zaitcev wrote:

> The initrd refuses to work for me without the attached patch
> (actually, initrd works, but nothing else does: console is hosed).
> I did not see anything on the list. Am I the only one who
> uses initrd?

No, you're not :)
I found that out just yesterday, but I think your patch is more elegant
than mine (just do close(0,1,2) buefore exit from handle_initrd()).

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
