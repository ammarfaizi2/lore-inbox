Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVELFH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVELFH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 01:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVELFH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 01:07:28 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:33421 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S261274AbVELFHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 01:07:21 -0400
Date: Thu, 12 May 2005 08:07:10 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: ted creedon <tcreedon@easystreet.com>
cc: openafs-info@openafs.org, linux-kernel@vger.kernel.org
Subject: RE: [OpenAFS] Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same
 for 2.4.30 and openafs 1.3.82
In-Reply-To: <20050509132508.55483B024@smtpauth.easystreet.com>
Message-ID: <Pine.LNX.4.62.0505120749180.19791@tassadar.physics.auth.gr>
References: <20050509132508.55483B024@smtpauth.easystreet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.30.0.12; VDF: 6.30.0.170; host: tassadar)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, ted creedon wrote:

> Looks like a compile problem if there's a symbol table error.
>
> To eliminate that as a cause:
> Make bzImage;make modules;make modules_install;make install;
> Reboot into the new image
> Run regen.sh then ./configure and built a new openafs system; install ane
> test it.
>
> I think there may be small differences in the m4 macros between various
> operating systems.
>
> This is the only way I can get reliable compiles. I have had one server
> crash with 1.3.81 but I suspect the software raid filesystem.
>


 	Hello ted ,

I folowed your advice , and now after 60 hours of continuous  usage I had 
no oops. I will keep stressing the system to see how it goes. Using 2.4.30 
and openafs 1.3.78 at the moment.

 	Thanks to everyone who replied :)


--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
=============================================================================



