Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267688AbUHPPPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267688AbUHPPPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbUHPPMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:12:54 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:29909
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267695AbUHPPKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:10:15 -0400
Message-ID: <4120CE51.3030309@bio.ifi.lmu.de>
Date: Mon, 16 Aug 2004 17:10:09 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
References: <2tB3a-7rU-19@gated-at.bofh.it> <2tOWp-cF-5@gated-at.bofh.it> <2tQlC-1kl-27@gated-at.bofh.it> <200408161706.26069.worf@sbox.tu-graz.ac.at>
In-Reply-To: <200408161706.26069.worf@sbox.tu-graz.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Scheicher wrote:

> unfortunately this isn't so
> 
> cdrecord itself only works as root
> as user, the list of supported modes remains empty, and trying to burn anway 
> gives the error
> cdrecord: Drive does not support <whatever i try> recording.
> cdrecord: Illegal write mode for this drive.

It should work as user when the suid bit it set.

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

