Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbTAQLMU>; Fri, 17 Jan 2003 06:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbTAQLMU>; Fri, 17 Jan 2003 06:12:20 -0500
Received: from [66.70.28.20] ([66.70.28.20]:5384 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267490AbTAQLMU>; Fri, 17 Jan 2003 06:12:20 -0500
Date: Fri, 17 Jan 2003 12:20:35 +0100
From: DervishD <raul@pleyades.net>
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: argv0 revisited...
Message-ID: <20030117112035.GH47@DervishD>
References: <20030115184455.GB47@DervishD> <200301161104.h0GB4IOY011937@eeyore.valparaiso.cl> <20030116112745.GE87@DervishD> <20030117115103.A5284@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030117115103.A5284@bitwizard.nl>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Rogier :)

> ln init klogd
> ln init slog
> ln init into

    Won't work, we fork, don't exec. I will need to rewrite a lot of
code just for converting the fork-scheme to a fork+exec-scheme.
Moreover, this will introduce vulnerabilities... It's not safe from
init to just exec 'klogd'. It will need full paths.

    Thanks for answering :)

    Raúl
