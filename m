Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSGPTYA>; Tue, 16 Jul 2002 15:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSGPTX7>; Tue, 16 Jul 2002 15:23:59 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5382 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317946AbSGPTX6>; Tue, 16 Jul 2002 15:23:58 -0400
Date: Tue, 16 Jul 2002 21:26:51 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716192651.GA22053@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020716123122.GE4576@merlin.emma.line.org> <Pine.LNX.4.44.0207160953110.3452-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207160953110.3452-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Thunder from the hill wrote:

> >                 if (fsync(fd) != 0)
> >                         err(1, "fsync %s", argv[1]);
> >                 close(fd);
> >         }
> 
> Pretty much the thing I had in mind, except that the close return code is 
> disregarded here...

Indeed, but OTOH, what error is close to report when the file is opened
read-only?
