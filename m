Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265334AbRGEPM2>; Thu, 5 Jul 2001 11:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265319AbRGEPMT>; Thu, 5 Jul 2001 11:12:19 -0400
Received: from pop.gmx.net ([194.221.183.20]:42479 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265334AbRGEPMJ>;
	Thu, 5 Jul 2001 11:12:09 -0400
Date: Thu, 5 Jul 2001 16:15:21 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705161521.A4755@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E15I79i-0002NI-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.5 i686
X-Editor: VIM - Vi IMproved 5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

On Thu, 05 Jul 2001, Alan Cox wrote:

> > This bug hits me since 2.4.6-pre5 but nobody answered to my emails... The
> > code line is identical (and the softirq.c:206 ofc).
> > 
> > Anyone, any idea?
> 
> None at all. There are odd items in your config - like khttpd which if 
> involved might explain why there are not more reports.
> 

But khttpd is compiled as a module which isn't loaded at the moment, the
crash appears. The crash is just after "Calibrating delay loop... 333.41
BogoMIPS". At this moment, there should be no modules loaded.

As others report the same error, it seems to be a conflict with Cyrix
processors.

Bye,

Manfred
-- 
 /"\                        | PGP-Key available at Public Key Servers
 \ /  ASCII ribbon campaign | or "http://www.mahowi.de/pgp/mahowi.asc"
  X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
 / \  and postings          | AIM: mahowi42   * ICQ: 61597169
