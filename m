Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132877AbRDEMb6>; Thu, 5 Apr 2001 08:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132878AbRDEMbs>; Thu, 5 Apr 2001 08:31:48 -0400
Received: from adsl-213-254-163-44.mistral-uk.net ([213.254.163.44]:11019 "EHLO
	crucigera.fysh.org") by vger.kernel.org with ESMTP
	id <S132877AbRDEMbe>; Thu, 5 Apr 2001 08:31:34 -0400
Date: Thu, 5 Apr 2001 13:30:51 +0100
From: Athanasius <Athanasius@miggy.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Another report of mozilla in D state, related to the 'uninterruptible sleep' thread
Message-ID: <20010405133051.A16246@miggy.org>
Mail-Followup-To: Athanasius <Athanasius@miggy.org>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3ACB727E.D8B7C824@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACB727E.D8B7C824@blue-labs.org>; from david@blue-labs.org on Wed, Apr 04, 2001 at 12:14:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 12:14:06PM -0700, David Ford wrote:
> I reported it back on Mar/27.  It is still an almost daily problem
> requiring a reboot.  Mozilla gets stuck in down_write_failed.  This time
> I'm sure it's not reiser's fault.

   Definitely nothing to do with ReiserFS as I've had this happen and
don't even have that FS compiled in.  2.4.3 (vanilla) was the kernel.
No trace or anything (quick grep of /var/log/kern.log* for past week or
so confirms), strace -p on it got nowhere at all.

-Ath
-- 
- Athanasius = Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
