Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbREaAvK>; Wed, 30 May 2001 20:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262935AbREaAvA>; Wed, 30 May 2001 20:51:00 -0400
Received: from [209.10.41.242] ([209.10.41.242]:63960 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262581AbREaAuu>;
	Wed, 30 May 2001 20:50:50 -0400
Mime-Version: 1.0
Message-Id: <p0510031ab73b43e89d24@[10.128.7.49]>
In-Reply-To: <20010531013827.J16761@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva>
 <9f41vq$our$1@cesium.transmeta.com> <p05100316b73b3f2e80e2@[10.128.7.49]>
 <20010531013827.J16761@parcelfarce.linux.theplanet.co.uk>
Date: Wed, 30 May 2001 17:44:39 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: How to know HZ from userspace?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:38 AM +0100 2001-05-31, Joel Becker wrote:
>On Wed, May 30, 2001 at 05:24:37PM -0700, Jonathan Lundell wrote:
>>  FWIW (perhaps not much in this context), the POSIX way is 
>>sysconf(_SC_CLK_TCK)
>>
>>  POSIX sysconf is pretty useful for this kind of thing (not just HZ, either).
>
>	Well, how many hundred things on Linux are available from /proc
>but not from sysconf or the like?  :-)
>
>Joel

Lots. Maybe we oughta have /proc/sysconf/... (there's no reason 
sysconf() can't be a library reading /proc).
-- 
/Jonathan Lundell.
