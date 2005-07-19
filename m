Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVGSLPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVGSLPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 07:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVGSLPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 07:15:46 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:58451 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261965AbVGSLPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 07:15:43 -0400
Date: Tue, 19 Jul 2005 13:15:42 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org,
       rth@twiddle.net, dhowells@redhat.com, kumar.gala@freescale.com,
       davem@davemloft.net, mhw@wittsend.com, support@comtrol.com,
       nils@kernelconcepts.de, chirag.kantharia@hp.com, Lionel.Bouton@inet6.fr,
       benh@kernel.crashing.org, mchehab@brturbo.com.br, laredo@gnu.org,
       rbultje@ronald.bitfreak.net, middelin@polyware.nl, philb@gnu.org,
       tim@cyberelk.net, campbell@torque.net, andrea@suse.de, mulix@mulix.org
Subject: Re: [PATCH] pci_find_device --> pci_get_device
Message-ID: <20050719111542.GA26422@bitwizard.nl>
References: <42DC4873.2080807@gmail.com> <20050719043621.GA14657@bitwizard.nl> <42DCDBB2.6070106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DCDBB2.6070106@gmail.com>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 12:53:38PM +0200, Jiri Slaby wrote:
> Rogier Wolff napsal(a):

> I don't know, if you think it global, or if am I here with other
> fellows (no, I'm not).  I don't know what kind of comment you have
> on your mind. Could you, please, specify it more.  I only changed
> names of called functions and added some pci_dev_put, what should I
> comment?

I meant: that IF I'm right that there needs to be more pci_dev_put, 
that needs to be noted in the source. 

If you know that there needs to be a put, but you have decided you
don't know where to put it exactly, then that needs to be in a comment
so that someone looking at the code after you will be able to put it
in. Otherwise the new person will think: He might have had a smarter
plan and will do the pci_dev_put somewhere else. 

	Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
