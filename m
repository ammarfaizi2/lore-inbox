Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTFKSQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 14:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTFKSQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 14:16:13 -0400
Received: from matrix.roma2.infn.it ([141.108.255.2]:14027 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id S263535AbTFKSQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 14:16:09 -0400
From: AlberT <AlberT@SuperAlberT.it>
Organization: SuperAlberT.it
To: Peter Osterlund <petero2@telia.com>, Vojtech Pavlik <vojtech@ucw.cz>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Date: Wed, 11 Jun 2003 20:29:42 +0200
User-Agent: KMail/1.5
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Joseph Fannin <jhf@rivenstone.net>
References: <m2smqhqk4k.fsf@p4.localdomain> <20030611170246.A4187@ucw.cz> <m27k7sv5si.fsf@telia.com>
In-Reply-To: <m27k7sv5si.fsf@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306112029.42467.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 June 2003 20:16, Peter Osterlund wrote:

> The w value is somewhat special and not really a real axis. According
> to the Synaptics TouchPad Interfacing Guide
> (http://www.synaptics.com/decaf/utilities/ACF126.pdf), W is defined as
> follows:
>
> Value		Needed capability	Interpretation
> W = 0		capMultiFinger		Two fingers on the pad.
> W = 1		capMultiFinger		Three or more fingers on the pad.
> W = 2		capPen			Pen (instead of finger) on the pad.
> W = 3		Reserved.
> W = 4-7		capPalmDetect		Finger of normal width.
> W = 8-14	capPalmDetect		Very wide finger or palm.
> W = 15		capPalmDetect		Maximum reportable width; extremely
> 					wide contact.
>
> Is there a better way than using ABS_MISC to pass the W information to
> user space?

may be W stays for Width ??  

ASB_WIDTH  would be something more significant !??

-- 
<?php echo '       Emiliano `AlberT` Gabrielli       '."\n".
           '  E-Mail: AlberT@SuperAlberT.it  '."\n".
           '  Web:    http://SuperAlberT.it  '."\n".
'  IRC:    #php,#AES azzurra.com '."\n".'ICQ: 158591185'; ?>
