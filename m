Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbUKPMbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUKPMbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 07:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbUKPMbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 07:31:19 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:4509 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261705AbUKPMbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 07:31:16 -0500
Date: Tue, 16 Nov 2004 13:31:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Simon Braunschmidt <braunschmidt@corscience.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <4199DDF2.5040700@corscience.de>
Message-ID: <Pine.LNX.4.53.0411161329440.15835@yvahk01.tjqt.qr>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> 
 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>  <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
  <84144f0204111602136a9bbded@mail.gmail.com>  <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
 <84144f020411160235616c529b@mail.gmail.com> <4199DDF2.5040700@corscience.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The have been
>> patches to get rid of the existing casts so please don't introduce new
>> ones.
>
>I vote for explicit casts, makes code more readable.

And makes it more error prone. Once upon a time, a user wrote:

	ptr = (int *)malloc(...)

And justified the use of the cast because gcc generated a warning, and I
replied that if he'd included <stdlib.h> (yeah, user space), the warning would
be gone, even without a cast. Sigh.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
