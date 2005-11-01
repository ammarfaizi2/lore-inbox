Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVKATPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVKATPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVKATPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:15:43 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:13219 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751160AbVKATPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:15:42 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Jeff V. Merkey" <jmerkey@utah-nac.org>
Subject: Re: Would I be violating the GPL?
Date: Tue, 1 Nov 2005 19:15:49 +0000
User-Agent: KMail/1.8.92
Cc: alex@alexfisher.me.uk, linux-kernel@vger.kernel.org
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com> <43679B22.8070905@utah-nac.org>
In-Reply-To: <43679B22.8070905@utah-nac.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011915.49480.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 16:43, Jeff V. Merkey wrote:
> Alan Cox and others have publicly stated that drivers, if complied stand
> alone with NO DEPENDENCIES ON KERNEL HEADERS (i.e. they do not
> incorporate in any way any kernel headers or source code tagged GPL) do
> not violate the GPL when provided with Linux. DSFS, NVidia, and several
> folks build kernel modules which are stand alone and are not objected to
> by the majority of folks.

If you even take 2 minutes to actually inspect the NVIDIA video driver sources 
(extract the .run file with --extract-only, and cd to usr/src/nv) you'll find 
the "glue" which is provided as source, but not under the GPL, does indeed 
#include kernel headers at compile time.

It does not distribute them, however, but it is completely nonsensical to 
class this as having "no dependency". It has a compile time and runtime 
dependency on the current kernel. What driver wouldn't?

> If these drivers include kernel headers as part of the build, then the
> drivers violate the GPL. Period. Check the code. If the vendor is
> including **ANY** GPL kernel headers, then they are required to open
> source the drivers. There are some zealots and GPL bigots that disagree
> with this, but Linux folks seem to be reasonable on this point.

There's clearly a grey area here, but I have no understanding of the law so I 
will not comment beyond stating fact. But you are at least wrong about the 
NVIDIA driver.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
