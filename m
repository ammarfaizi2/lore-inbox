Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314063AbSDKOKd>; Thu, 11 Apr 2002 10:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314067AbSDKOKc>; Thu, 11 Apr 2002 10:10:32 -0400
Received: from angband.namesys.com ([212.16.7.85]:45696 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S314063AbSDKOKb>; Thu, 11 Apr 2002 10:10:31 -0400
Date: Thu, 11 Apr 2002 18:10:27 +0400
From: Oleg Drokin <green@namesys.com>
To: ted@psyber.com, linux-kernel@vger.kernel.org,
        Hans Reiser <reiser@namesys.com>
Subject: Re: New IDE code and DMA failures
Message-ID: <20020411181027.A1870@namesys.com>
In-Reply-To: <200204111236.g3BCaMX10247@Port.imtp.ilyichevsk.odessa.ua> <20020411130544.GA8163@dondra.ofc.psyber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Apr 11, 2002 at 06:05:44AM -0700, Ted Deppner wrote:
 
> In one of my tests the contents /dev/hdh was additionally corrupted (a
> write test to /dev/hdh1) so badly that the partion information changed
> from type 83 to type 3 (Xenix), and the contents of a reiser partition so
> badly damaged that a --rebuild-tree and later a --rebuild-sb to reiserfsck
> didn't restore it to usable. (I put those options in at the request of
> reiserfsck, and I haven't wiped the drive yet if someone would like
> further tests against the reiserfs partition).

We are interested in such a damaged partitions that makes current reiserfsck
to segfault or to incorrectly repair FS (incorrectly in the meaning that
subsequent reiserfsck run finds more errors)
Is this the case with you?

Bye,
    Oleg
